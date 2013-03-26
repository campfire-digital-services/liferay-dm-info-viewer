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

<%@ page import="com.liferay.portal.kernel.util.StringUtil" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%@ page import="com.liferay.portal.kernel.log.Log" %>
<%@ page import="com.liferay.portal.kernel.log.LogFactoryUtil" %>


<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>


<%-- Define local variables as per default folder actions page --%>

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


<%-- Render default folder action page --%>

<liferay-util:buffer var="folderActionHtml">
    <liferay-util:include page="/html/portlet/document_library/folder_action.portal.jsp" />
</liferay-util:buffer> 


<%-- Render custom folder action page --%>

<liferay-util:buffer var="customFolderActionHtml">
	<liferay-ui:icon-menu align='<%= (portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY) || portletName.equals(PortletKeys.MEDIA_GALLERY_DISPLAY)) ? "right" : "auto" %>' direction='<%= (portletName.equals(PortletKeys.MEDIA_GALLERY_DISPLAY) || portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY)) ? null : "down" %>' extended="<%= (portletName.equals(PortletKeys.MEDIA_GALLERY_DISPLAY) || portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY)) ? true : false %>" icon="<%= (portletName.equals(PortletKeys.MEDIA_GALLERY_DISPLAY) || portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY)) ? null : StringPool.BLANK %>" message='<%= (portletName.equals(PortletKeys.MEDIA_GALLERY_DISPLAY) || portletName.equals(PortletKeys.DOCUMENT_LIBRARY_DISPLAY)) ? "actions" : StringPool.BLANK %>' showExpanded="<%= view %>" showWhenSingleIcon="<%= showWhenSingleIcon %>">
		<c:if test="<%= showActions %>">
		    <c:if test="<%= (folder != null) && !folder.isMountPoint() && DLFolderPermission.contains(permissionChecker, scopeGroupId, folderId, ActionKeys.VIEW) %>">
		    	
					<portlet:renderURL var="folderInfoURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
						<portlet:param name="struts_action" value="/document_library/folder_info"/>
						<portlet:param name="redirect" value="<%= currentURL %>"/>
						<portlet:param name="folderId" value="<%= String.valueOf(folderId) %>" />
						<portlet:param name="repositoryId" value="<%= String.valueOf(repositoryId) %>" />
					</portlet:renderURL>
					
					<%
					String folderInfoPopupTitle = "" + folderId;
					if (folder != null) {
						folderInfoPopupTitle = folder.getName();
						folderInfoPopupTitle += " (" + folderId + ")";
					}
					%>
					
					<script type="text/javascript">
						function showFolderInfoPopup() {
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
					
			        <liferay-ui:icon
			            image="attributes"
			            message='<%= LanguageUtil.get(pageContext, "view-folder-info") %>'
			            url='javascript:showFolderInfoPopup();'
			        />	
			</c:if>
		</c:if>
	</liferay-ui:icon-menu>	
</liferay-util:buffer>


<%-- Rebuild folder action HTML using custom folder action menu --%>

<%
String sourceHtml = folderActionHtml;

final String WEBDAV_ACTION_CLASS_SUFFIX = "-webdav-action";
final int WEBDAV_ACTION_CLASS_SUFFIX_LEN = WEBDAV_ACTION_CLASS_SUFFIX.length();

final String START_LIST_TAG = "<ul";
final String END_LIST_TAG = "</ul>";

final int START_LIST_TAG_LEN = START_LIST_TAG.length();
final int END_LIST_TAG_LEN = END_LIST_TAG.length();

final String START_LIST_ITEM_TAG = "<li";
final String END_LIST_ITEM_TAG = "</li>";

final int START_LIST_ITEM_TAG_LEN = START_LIST_ITEM_TAG.length();
final int END_LIST_ITEM_TAG_LEN = END_LIST_ITEM_TAG.length();


if (!StringUtils.isEmpty(sourceHtml)) {
	LOG.info("sourceHtml.length: " + sourceHtml.length());
	if (LOG.isDebugEnabled()) {
		LOG.debug("sourceHtml begin");
		LOG.debug(sourceHtml);
		LOG.debug("sourceHtml end");	
	}
}

if (!StringUtils.isEmpty(customFolderActionHtml)) {
	LOG.info("customFolderActionHtml.length: " + customFolderActionHtml.length());
	if (LOG.isDebugEnabled()) {
		LOG.debug("customFolderActionHtml begin");
		LOG.debug(customFolderActionHtml);
		LOG.debug("customFolderActionHtml end");
	}
}


// Find "Access from Desktop" menu item, which is the last menu item.
// i.e. find webdav-action class suffix for list item snippet "<li class="esje_-webdav-action">"

int webdavActionClassSnippetIndex = sourceHtml.lastIndexOf( WEBDAV_ACTION_CLASS_SUFFIX );
LOG.debug("webdavActionClassSnippetIndex: " + webdavActionClassSnippetIndex);

int customFolderActionListItemInsertIndex = (-1);
String customFolderActionListItemHtml = StringPool.BLANK;

if (webdavActionClassSnippetIndex > 0) {
	
	// Find list item index for "Access from Desktop" menu item
	// i.e. find list item tag start for list item snippet "<li class="esje_-webdav-action">" 
	
	int webdavActionListItemIndex = sourceHtml.lastIndexOf( START_LIST_ITEM_TAG, webdavActionClassSnippetIndex );
	LOG.debug("webdavActionListItemIndex: " + webdavActionListItemIndex);
	
	if (webdavActionListItemIndex > 0) {
		customFolderActionListItemInsertIndex = webdavActionListItemIndex;
		LOG.debug("customFolderActionListItemInsertIndex: " + customFolderActionListItemInsertIndex);
		
		// Extract custom action HTML from enclosing parent list tag
		// NOTE: The liferay-ui:icon-menu tag is required to correctly render the list items, 
		// but only the resulting nested list item is required; the parent list is redundant.
		
		if (!StringUtils.isEmpty(customFolderActionHtml)) {
			int customFolderActionListStartIndex = customFolderActionHtml.lastIndexOf(START_LIST_TAG);
			LOG.debug("customFolderActionListStartIndex: " + customFolderActionListStartIndex);
			
			if (customFolderActionListStartIndex > 0) {
				int customFolderActionListItemStartIndex = customFolderActionListStartIndex + START_LIST_TAG_LEN + 1;
				LOG.debug("customFolderActionListItemStartIndex: " + customFolderActionListItemStartIndex);
				
				if (customFolderActionListItemStartIndex > 0) {
					int customFolderActionListEndIndex = customFolderActionHtml.indexOf(END_LIST_TAG, customFolderActionListItemStartIndex);
					LOG.debug("customFolderActionListEndIndex: " + customFolderActionListEndIndex);

					int customFolderActionListItemEndIndex = customFolderActionListEndIndex;
					LOG.debug("customFolderActionListItemEndIndex: " + customFolderActionListItemEndIndex);
					
					customFolderActionListItemHtml = customFolderActionHtml.substring( customFolderActionListItemStartIndex, customFolderActionListItemEndIndex );
					
					if (LOG.isDebugEnabled()) {
						if (!StringUtils.isEmpty(customFolderActionHtml)) {
							LOG.debug("customFolderActionListItemHtml.length: " + customFolderActionListItemHtml.length());
							LOG.debug("customFolderActionListItemHtml: " + customFolderActionListItemHtml);
						}
					}
				}
			}
		}
	}
}


// Insert custom action before "Access from Desktop" menu item, which is the last menu item.
// i.e. find webdav-action class suffix for list item snippet "<li class="esje_-webdav-action">"

String resultHtml = sourceHtml;

if ((customFolderActionListItemInsertIndex > 0) && !StringUtils.isEmpty(customFolderActionListItemHtml)) {
	if (LOG.isInfoEnabled()) {
		LOG.info("inserting custom folder html into source html ...");
		LOG.info("sourceHtml.length: " + sourceHtml.length());
		LOG.info("customFolderActionListItemHtml.length: " + customFolderActionListItemHtml.length());		
		LOG.info("customFolderActionListItemInsertIndex: " + customFolderActionListItemInsertIndex);
	}
	
	resultHtml = StringUtil.insert( sourceHtml, customFolderActionListItemHtml, customFolderActionListItemInsertIndex );
	
	LOG.info("insert complete");
}


if (!StringUtils.isEmpty(resultHtml)) {
	LOG.info("resultHtml.length: " + resultHtml.length());
	if (LOG.isDebugEnabled()) {
		LOG.debug("resultHtml begin");
		LOG.debug(resultHtml);
		LOG.debug("resultHtml end");	
	}	
}
%>


<%-- Return resulting HTML --%>

<%= resultHtml %> 

<%!
private static Log LOG = LogFactoryUtil.getLog("portal-web.docroot.html.portlet.document_library.folder_action.jsp");
%>
