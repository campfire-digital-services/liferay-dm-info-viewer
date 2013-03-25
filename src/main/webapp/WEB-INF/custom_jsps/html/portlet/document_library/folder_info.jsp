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

<%
final int MAX_DESC_LENGTH = 40;
final String ELLIPSIS = "...";

String redirect = ParamUtil.getString(request, "redirect");

Map folderInfoMap = (Map)request.getAttribute("folderInfoMap");

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
if (!StringUtils.isEmpty(repositoryDescription)) {
	repositoryDescription = StringUtil.shorten(repositoryDescription, MAX_DESC_LENGTH, ELLIPSIS);
}

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

String folderInfoHeading = folderName + StringPool.SPACE + StringPool.OPEN_PARENTHESIS + folderId + StringPool.CLOSE_PARENTHESIS; 
String folderFileCountStr = folderUsageFolderCount + " Folder(s)" + ", " + folderUsageFileCount + " File(s)";

String folderUsageFolderSizeStr = FileUtils.byteCountToDisplaySize(folderUsageFolderSize);
if (folderUsageFolderSizeStr != null) {
	if (!folderUsageFolderSizeStr.endsWith("bytes")) {
		folderUsageFolderSizeStr += " (" + folderUsageFolderSize + " bytes)";
	}
}
%>

<aui:form action=""> 
<div>
<h2 class="header-title">
<liferay-ui:icon image="folder_open" />&nbsp;<%= folderInfoHeading %>
</h2>
<hr>
<aui:fieldset label="Folder Details">
<ul>
<li>ID: <%= folderId %></li>
<li>Name: <%= folderName %></li>
<li>Description: <%= folderDescription %></li>
<li>Location: <%= folderPath %></li>
<li>Size: <%= folderUsageFolderSizeStr %></li>
<li>Contents: <%= folderFileCountStr %></li>
<li>Creation Date: <%= folderCreateDateStr %></li>
<li>Owner: <%= folderUserId %></li>
</ul>
</aui:fieldset>
<aui:fieldset label="Repository Details">
<ul>
<li>ID: <%= repositoryId %></li>
<li>Name: <%= repositoryName %></li>
<li>Type: <%= repositoryType %></li>
<li>Description: <%= repositoryDescription %></li>
</ul>
</aui:fieldset>
</div>
</aui:form>
