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

<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<%
String randomNamespace = null;

if (portletName.equals(PortletKeys.DOCUMENT_LIBRARY)) {
	randomNamespace = PortalUtil.generateRandomKey(request, "portlet_document_library_folder_action") + StringPool.UNDERLINE;
}
else if (portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY)) {
	randomNamespace = PortalUtil.generateRandomKey(request, "portlet_document_library_display_folder_action") + StringPool.UNDERLINE;
}
else {
	randomNamespace = PortalUtil.generateRandomKey(request, "portlet_image_gallery_display_folder_action") + StringPool.UNDERLINE;
}

String redirect = currentURL;

ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Folder folder = null;

long folderId = 0;

long repositoryId = 0;

if (row != null) {
	Object result = row.getObject();

	if (result instanceof Folder) {
		folder = (Folder)result;

		folderId = folder.getFolderId();

		repositoryId = folder.getRepositoryId();
	}
}
else {
	if (portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY) || portletName.equals(PortletKeys.MEDIA_GALLERY_DISPLAY)) {
		folder = (Folder)request.getAttribute("view.jsp-folder");

		folderId = GetterUtil.getLong((String)request.getAttribute("view.jsp-folderId"));

		repositoryId = GetterUtil.getLong((String)request.getAttribute("view.jsp-repositoryId"));
	}
	else {
		folder = (Folder)request.getAttribute("view_entries.jsp-folder");

		folderId = GetterUtil.getLong((String)request.getAttribute("view_entries.jsp-folderId"));

		repositoryId = GetterUtil.getLong((String)request.getAttribute("view_entries.jsp-repositoryId"));
	}
}

int status = WorkflowConstants.STATUS_APPROVED;

if (permissionChecker.isCompanyAdmin() || permissionChecker.isGroupAdmin(scopeGroupId)) {
	status = WorkflowConstants.STATUS_ANY;
}

boolean folderSelected = GetterUtil.getBoolean((String)request.getAttribute("view_entries.jsp-folderSelected"));

String modelResource = null;
String modelResourceDescription = null;
String resourcePrimKey = null;

boolean showPermissionsURL = false;

if (folder != null) {
	modelResource = DLFolderConstants.getClassName();
	modelResourceDescription = folder.getName();
	resourcePrimKey = String.valueOf(folderId);

	showPermissionsURL = DLFolderPermission.contains(permissionChecker, folder, ActionKeys.PERMISSIONS);
}
else {
	modelResource = "com.liferay.portlet.documentlibrary";
	modelResourceDescription = themeDisplay.getScopeGroupName();
	resourcePrimKey = String.valueOf(scopeGroupId);

	showPermissionsURL = DLPermission.contains(permissionChecker, scopeGroupId, ActionKeys.PERMISSIONS);
}

boolean showWhenSingleIcon = false;

if ((row == null) || portletId.equals(PortletKeys.DOCUMENT_LIBRARY)) {
	showWhenSingleIcon = true;
}

boolean view = false;

if ((row == null) && (portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY) || portletName.equals(PortletKeys.MEDIA_GALLERY_DISPLAY))) {
	view = true;
}
%>

<%
LOG.debug("currentURL: " + currentURL);		
LOG.debug("folderId: " + folderId);
LOG.debug("repositoryId: " + repositoryId);
%>

<liferay-util:buffer var="iconMenuExt">
	<c:if test="<%= showActions %>">
	    <c:if test="<%= (folder != null) && !folder.isMountPoint() && DLFolderPermission.contains(permissionChecker, scopeGroupId, folderId, ActionKeys.VIEW) %>">
	    	
				<portlet:renderURL var="folderInfoURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
					<portlet:param name="struts_action" value="/document_library/folder_info"/>
					<portlet:param name="redirect" value="<%= currentURL %>"/>
					<portlet:param name="folderId" value="<%= String.valueOf(folderId) %>" />
					<portlet:param name="repositoryId" value="<%= String.valueOf(repositoryId) %>" />
				</portlet:renderURL>
				
				<%
				String folderInfoPopupTitle = "Folder: " + folderId;
				if (folder != null) {
					folderInfoPopupTitle = "Folder: " + folder.getName();
				}
				%>
				
				<script type="text/javascript">
					function showFolderInfoPopup_<%= folderId %>() {
					   AUI().use('aui-dialog', 'aui-io', 'event', 'event-custom', function(A) {
					    
					    var popup = new A.Dialog({
					            title: '<%= folderInfoPopupTitle %>',
					            centered: true,
					            draggable: true,
					            modal: true,
								width: 500,
								height: 420,
								destroyOnClose: true
					        }).plug(A.Plugin.IO, {uri: '<%= folderInfoURL %>'}).render();
					        
					    popup.show();
					  });
					} 
				</script>
				
				<%
				String iconURL = "javascript:showFolderInfoPopup_" + folderId + "();";
				%>
				
		        <liferay-ui:icon
		            image="attributes"
		            message='<%= LanguageUtil.get(pageContext, "view-folder-info") %>'
		            url='<%= iconURL %>'
		        />	
		</c:if>
	</c:if>
</liferay-util:buffer>

<%= iconMenuExt %> 

<%!
private static Log LOG = LogFactoryUtil.getLog("portal-web.docroot.html.portlet.document_library.folder_actions_menu_ext.show_info.jsp");
%>
