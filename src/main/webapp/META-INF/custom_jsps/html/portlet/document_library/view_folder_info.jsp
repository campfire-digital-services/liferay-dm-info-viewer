<%--
/**
* Copyright (C) 2013 Permeance Technologies
*
* This program is free software: you can redistribute it and/or modify it under the terms of the
* GNU General Public License as published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
* even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public License along with this program. If
* not, see <http://www.gnu.org/licenses/>.
*/
--%>

<%@ include file="/html/portlet/document_library/init.jsp" %>

<%@ page import="java.text.Format" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.liferay.portal.kernel.util.FastDateFormatConstants" %>
<%@ page import="com.liferay.portal.kernel.util.FastDateFormatFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.MapUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.StringUtil" %>
<%@ page import="com.liferay.portal.security.permission.ResourceActionsUtil" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<style>
.aui .modal-body {
    max-height: 500px;
    overflow-y: auto;
    padding: 5px;
    position: relative;
    margin-top: 0x;
    margin-bottom: 5px;
    margin-left: 5px;
    margin-right: 5px;
}
.aui h1, .aui h2, .aui h3, .aui h4, .aui h5, .aui h6 {
    margin-top: 5px;
    margin-bottom: 5px;
    margin-left: 0px;
    margin-right: 0px;
}
.aui .control-group {
    margin-bottom: 5px;
}
.aui legend {
    font-size: 18px;
    margin-bottom: 5px;
}
.aui .fieldset {
	margin-top: 0px;
	margin-bottom: 10px;
	margin-left: 0px;
	margin-right: 0px;
}
.aui .field-content, .aui .field-row, .aui .button-holder, .aui .field-wrapper {
	margin: 0px 0px;
}
.aui .field-wrapper {
	margin-top: 2px;
	margin-bottom: 2px;
	margin-left: 0px;
	margin-right: 0px;
}
.header-title {
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 0px;
	margin-right: 0px;
}
</style>

<%
final int MAX_DESC_LENGTH = 60;
final String ELLIPSIS = "...";

String redirect = ParamUtil.getString(request, "redirect");

Map folderInfoMap = (Map)request.getAttribute("folderInfoMap");

long folderId = MapUtil.getLong(folderInfoMap, "folderId");

String folderName = MapUtil.getString(folderInfoMap, "folderName");
if (StringUtils.isEmpty(folderName)) {
	folderName = StringPool.BLANK + folderId;
}

String folderCreateDateStr = StringPool.BLANK;
Format dateFormatFolderDateTime = FastDateFormatFactoryUtil.getDateTime(locale, timeZone);
Date folderCreateDate = (Date)folderInfoMap.get("folderCreateDate");
if (folderCreateDate != null ) {
	folderCreateDateStr = folderCreateDate.toString();
	if (dateFormatFolderDateTime != null) {
		folderCreateDateStr = dateFormatFolderDateTime.format(folderCreateDate);		
	}
}
	
String folderDescription = MapUtil.getString(folderInfoMap, "folderDescription");
if (!StringUtils.isEmpty(folderDescription)) {
	folderDescription = StringUtil.shorten(folderDescription, MAX_DESC_LENGTH, ELLIPSIS);
}
long folderUsageFolderSize = MapUtil.getLong(folderInfoMap, "folderUsageFolderSize");
long folderUsageFolderCount = MapUtil.getLong(folderInfoMap, "folderUsageFolderCount");
long folderUsageFileCount = MapUtil.getLong(folderInfoMap, "folderUsageFileCount");
String folderPath = MapUtil.getString(folderInfoMap, "folderPath");
long folderUserId = MapUtil.getLong(folderInfoMap, "folderUserId");
String folderUserFullName = MapUtil.getString(folderInfoMap, "folderUserFullName");
String folderOwner = ""+folderUserId;
if (!StringUtils.isEmpty(folderUserFullName)) {
	folderOwner = folderUserFullName + " (" + folderUserId + ")";
}

String folderInfoHeading = folderName;
String folderFileCountStr = folderUsageFolderCount + " Folder";
if (folderUsageFolderCount != 1) {
	folderFileCountStr += "s";
}
folderFileCountStr += ", " + folderUsageFileCount + " File";
if (folderUsageFileCount != 1) {
	folderFileCountStr += "s";
}

String folderUsageFolderSizeStr = FileUtils.byteCountToDisplaySize(folderUsageFolderSize);
if (folderUsageFolderSizeStr != null) {
	if (!folderUsageFolderSizeStr.endsWith("bytes")) {
		folderUsageFolderSizeStr += " (" + folderUsageFolderSize + " bytes)";
	}
}

long repositoryId = MapUtil.getLong(folderInfoMap, "repositoryId");
String repositoryName = MapUtil.getString(folderInfoMap, "repositoryName");
if (StringUtils.isEmpty(repositoryName)) {
	repositoryName = "Local";
}
String repositoryClassName = MapUtil.getString(folderInfoMap, "repositoryClassName");

String repositoryType = "Local";
if (!StringUtils.isEmpty(repositoryClassName)) {
	repositoryType = ResourceActionsUtil.getModelResource(locale, repositoryClassName); 
}

String repositoryDescription = MapUtil.getString(folderInfoMap, "repositoryDescription");
if (StringUtils.isEmpty(repositoryDescription)) {
	if ("Local".equals(repositoryType)) {
		repositoryDescription = "Local Repository";		
	}
} else {
	repositoryDescription = StringUtil.shorten(repositoryDescription, MAX_DESC_LENGTH, ELLIPSIS);
}
%>

<aui:form action=""> 
<div>
<h3 class="header-title">
	<liferay-ui:icon image="folder_open" />&nbsp;<%= folderInfoHeading %>
</h3>
<aui:fieldset label="folder-details">
	<aui:field-wrapper label="ID:" inlineLabel="true" first="true" >
		<%= folderId %>
	</aui:field-wrapper>

	<aui:field-wrapper label="Name:" inlineLabel="true">
		<%= folderName %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Description:" inlineLabel="true">
		<%= folderDescription %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Location:" inlineLabel="true">
		<%= folderPath %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Size:" inlineLabel="true">
		<%= folderUsageFolderSizeStr %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Contents:" inlineLabel="true">
		<%= folderFileCountStr %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Creation Date:" inlineLabel="true">
		<%= folderCreateDateStr %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Owner:" inlineLabel="true" last="true">
		<%= folderOwner %>
	</aui:field-wrapper>
</aui:fieldset>
<aui:fieldset label="repository-details">
	<aui:field-wrapper label="ID:" inlineLabel="true" first="true">
		<%= repositoryId %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Name:" inlineLabel="true">
		<%= repositoryName %>
	</aui:field-wrapper>
	
	<aui:field-wrapper label="Type:" inlineLabel="true">
		<%= repositoryType %>
	</aui:field-wrapper>		
	
	<aui:field-wrapper label="Description:" inlineLabel="true" last="true">
		<%= repositoryDescription %>
	</aui:field-wrapper>
</aui:fieldset>	
</div>
</aui:form>
