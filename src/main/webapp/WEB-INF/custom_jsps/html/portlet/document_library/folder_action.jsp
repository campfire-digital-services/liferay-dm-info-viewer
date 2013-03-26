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


<%-- Render default folder action page --%>

<liferay-util:buffer var="folderActionHtml">
    <liferay-util:include page="/html/portlet/document_library/folder_action.portal.jsp" />
</liferay-util:buffer> 


<%-- Render custom folder action page --%>

<liferay-util:buffer var="folderActionExtHtml">
    <liferay-util:include page="/html/portlet/document_library/folder_action_ext.jsp" />
</liferay-util:buffer> 


<%-- Rebuild folder action HTML using custom folder action menu --%>

<%
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

String sourceHtml = folderActionHtml;

if (!StringUtils.isEmpty(sourceHtml)) {
	LOG.info("folderActionHtml.length: " + folderActionHtml.length());
	if (LOG.isDebugEnabled()) {
		LOG.debug("folderActionHtml begin");
		LOG.debug(folderActionHtml);
		LOG.debug("folderActionHtml end");	
	}
}

if (!StringUtils.isEmpty(sourceHtml)) {
	LOG.info("sourceHtml.length: " + sourceHtml.length());
}

if (!StringUtils.isEmpty(folderActionExtHtml)) {
	LOG.info("folderActionExtHtml.length: " + folderActionExtHtml.length());
	if (LOG.isDebugEnabled()) {
		LOG.debug("folderActionExtHtml begin");
		LOG.debug(folderActionExtHtml);
		LOG.debug("folderActionExtHtml end");
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
		
		if (!StringUtils.isEmpty(folderActionExtHtml)) {
			int customFolderActionListStartIndex = folderActionExtHtml.lastIndexOf(START_LIST_TAG);
			LOG.debug("customFolderActionListStartIndex: " + customFolderActionListStartIndex);
			
			if (customFolderActionListStartIndex > 0) {
				int customFolderActionListItemStartIndex = customFolderActionListStartIndex + START_LIST_TAG_LEN + 1;
				LOG.debug("customFolderActionListItemStartIndex: " + customFolderActionListItemStartIndex);
				
				if (customFolderActionListItemStartIndex > 0) {
					int customFolderActionListEndIndex = folderActionExtHtml.indexOf(END_LIST_TAG, customFolderActionListItemStartIndex);
					LOG.debug("customFolderActionListEndIndex: " + customFolderActionListEndIndex);

					int customFolderActionListItemEndIndex = customFolderActionListEndIndex;
					LOG.debug("customFolderActionListItemEndIndex: " + customFolderActionListItemEndIndex);
					
					customFolderActionListItemHtml = folderActionExtHtml.substring( customFolderActionListItemStartIndex, customFolderActionListItemEndIndex );
					
					if (LOG.isDebugEnabled()) {
						if (!StringUtils.isEmpty(folderActionExtHtml)) {
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
