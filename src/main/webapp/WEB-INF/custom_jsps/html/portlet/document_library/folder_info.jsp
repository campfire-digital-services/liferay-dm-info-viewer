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

<%@ page import="java.util.Map" %>
<%@ page import="com.liferay.portal.kernel.util.MapUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%
String redirect = ParamUtil.getString(request, "redirect");

Map folderInfoMap = (Map)request.getAttribute("folderInfoMap");

long folderId = MapUtil.getLong(folderInfoMap, "folderId");
String folderName = MapUtil.getString(folderInfoMap, "folderName");
if (StringUtils.isEmpty(folderName)) {
	folderName = StringPool.BLANK + folderId;
}

long repositoryId = MapUtil.getLong(folderInfoMap, "repositoryId");
String repositoryName = MapUtil.getString(folderInfoMap, "repositoryName");
if (StringUtils.isEmpty(repositoryName)) {
	repositoryName = StringPool.BLANK + repositoryId;
}

long folderSize = MapUtil.getLong(folderInfoMap, "folderSize");
long folderCount = MapUtil.getLong(folderInfoMap, "folderCount");
long fileCount = MapUtil.getLong(folderInfoMap, "fileCount");
String folderLocation = MapUtil.getString(folderInfoMap, "folderLocation");

String folderInfoHeading = folderName + StringPool.SPACE + StringPool.OPEN_PARENTHESIS + folderId + StringPool.CLOSE_PARENTHESIS; 
String folderContentSummary = folderCount + " Folders" + ", " + fileCount + " Files";

String folderSizeStr = FileUtils.byteCountToDisplaySize(folderSize);
if (folderSizeStr != null) {
	if (!folderSizeStr.endsWith("bytes")) {
		folderSizeStr += " (" + folderSize + " bytes)";
	}
}
%>

<div>
<h1>
<liferay-ui:icon image="folder_open" />&nbsp;<%= folderInfoHeading %>
</h1>
<hr>
<ul>
<li>Folder ID: <%= folderId %></li>
<li>Folder Name: <%= folderName %></li>
<li>Repository ID: <%= repositoryId %></li>
<li>Repository Name: <%= repositoryName %></li>
<li>Folder Location: <%= folderLocation %></li>
<li>Folder Size: <%= folderSizeStr %></li>
<li>Folder Contents: <%= folderContentSummary %></li>
</ul>
<%--
<p>
Folder Info Map: <%= folderInfoMap %>
</p>
--%>
</div>

<%
ParamUtil.print(request);
%>
