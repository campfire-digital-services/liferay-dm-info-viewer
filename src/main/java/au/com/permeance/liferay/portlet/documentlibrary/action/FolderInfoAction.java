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

package au.com.permeance.liferay.portlet.documentlibrary.action;

import au.com.permeance.liferay.portlet.documentlibrary.model.DLFolderInfo;
import au.com.permeance.liferay.portlet.documentlibrary.model.DLFolderUsage;
import au.com.permeance.liferay.portlet.documentlibrary.service.DLFolderUsageServiceUtil;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.struts.BaseStrutsPortletAction;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.Repository;
import com.liferay.portal.security.auth.PrincipalException;
import com.liferay.portal.security.permission.ActionKeys;
import com.liferay.portal.security.permission.PermissionChecker;
import com.liferay.portal.security.permission.PermissionThreadLocal;
import com.liferay.portal.service.RepositoryServiceUtil;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.ServiceContextFactory;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.documentlibrary.service.DLAppServiceUtil;

import java.util.HashMap;
import java.util.Map;

import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;


/**
 * Folder Usage Action.
 * 
 * This action calculates the usage of a folder (including sub-folders and files).
 * 
 * @author Tim Telcik <tim.telcik@permeance.com.au>
 */
public class FolderInfoAction extends BaseStrutsPortletAction {

    private static final Log s_log = LogFactoryUtil.getLog(FolderInfoAction.class);

    
    @Override
	public String render( PortletConfig portletConfig, RenderRequest renderRequest, RenderResponse renderResponse)
		throws Exception {

        final String FOLDER_INFO_PAGE_PATH = "/portlet/document_library/view_folder_info.jsp";
        
        DLFolderInfo folderInfo = buildFolderInfo(renderRequest, renderResponse);
        
        if (s_log.isDebugEnabled()) {
        	s_log.debug("folderInfo: " + folderInfo);
        }
        
        Map<String,Object> folderInfoMap = buildFolderInfoMap( folderInfo );
        
        if (s_log.isDebugEnabled()) {
        	s_log.debug("folderInfoMap: " + folderInfoMap);
        }

        renderRequest.setAttribute("folderInfoMap", folderInfoMap);
        
        return FOLDER_INFO_PAGE_PATH;
	}
	
    
    protected DLFolderInfo buildFolderInfo( RenderRequest renderRequest, RenderResponse renderResponse ) throws Exception {

        ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
        long groupId = ParamUtil.getLong(renderRequest, "groupId");
        long scopeGroupId = themeDisplay.getScopeGroupId();
        String scopeGroupName = themeDisplay.getScopeGroupName();
        long repositoryId = ParamUtil.getLong(renderRequest, "repositoryId");
        long folderId = ParamUtil.getLong(renderRequest, "folderId");
        Folder folder = DLAppServiceUtil.getFolder(folderId);
        ServiceContext serviceContext = ServiceContextFactory.getInstance(Folder.class.getName(), renderRequest);
        
        if (s_log.isDebugEnabled()) {
        	s_log.debug("building folder info ...");
        	ParamUtil.print(renderRequest);
        	s_log.debug("groupId: " + groupId);
        	s_log.debug("scopeGroupId: " + scopeGroupId);
        	s_log.debug("scopeGroupName: " + scopeGroupName);
        	s_log.debug("repositoryId: " + repositoryId);
        	s_log.debug("folderId: " + folderId);
        }

        PermissionChecker permissionChecker = PermissionThreadLocal.getPermissionChecker();

        if (!folder.containsPermission(permissionChecker, ActionKeys.VIEW)) {
        	throw new PrincipalException();
        }
        
        DLFolderInfo folderInfo = new DLFolderInfo();
        
        try {
        	
        	DLFolderUsage folderUsage = DLFolderUsageServiceUtil.calculateFolderUsage( repositoryId, folderId, serviceContext );

        	folderInfo.setFolderId(folderId);
        	folderInfo.setFolderName(folder.getName());
        	folderInfo.setFolderCreateDate(folder.getCreateDate());
        	folderInfo.setFolderDescription(folder.getDescription());
        	folderInfo.setFolderPath(buildPath(folder));
        	folderInfo.setFolderUsage(folderUsage);
        	folderInfo.setFolderUserId(folder.getUserId());
        	
        	folderInfo.setRepositoryId(repositoryId);
        	
        	Repository repository = null;
    		if (repositoryId != scopeGroupId) {
    			repository = RepositoryServiceUtil.getRepository(repositoryId);
    			if (repository != null) {
        			folderInfo.setRepositoryName(repository.getName());
        			folderInfo.setRepositoryClassName(repository.getClassName());
        			folderInfo.setRepositoryDescription(repository.getDescription());
    			}
    		}
        	
        } catch (Exception e) {
        	
        	String msg = "Error building information for folder " + folderId 
        				+ " in repository " + repositoryId
        				+ " : " + e.getMessage();
        	
        	s_log.error( msg, e );
        	
        	throw new PortalException( msg, e ); 
        	
        } finally {
        	
        	// placeholder
            
        }
        
        return folderInfo;
    }
    
    
    protected Map<String,Object> buildFolderInfoMap( DLFolderInfo folderInfo ) {
    	
        Map<String,Object> map = new HashMap<String,Object>();

        map.put("folderCreateDate", folderInfo.getFolderCreateDate());
        map.put("folderDescription", folderInfo.getFolderDescription());
        map.put("folderId", folderInfo.getFolderId());
        map.put("folderName", folderInfo.getFolderName());
        map.put("folderPath", folderInfo.getFolderPath());
        map.put("folderUsageFileCount", folderInfo.getFolderUsage().getFileCount());
        map.put("folderUsageFolderCount", folderInfo.getFolderUsage().getFolderCount());        
        map.put("folderUsageFolderSize", folderInfo.getFolderUsage().getFolderSize());  
        map.put("folderUserId", folderInfo.getFolderUserId());
        map.put("repositoryId", folderInfo.getRepositoryId());
        map.put("repositoryName", folderInfo.getRepositoryName());
        map.put("repositoryClassName", folderInfo.getRepositoryClassName());
        map.put("repositoryDescription", folderInfo.getRepositoryDescription());

        return map;
    }
    
    
	public String buildPath( Folder folder ) throws PortalException, SystemException {
		
		StringBuilder sb = new StringBuilder();

		Folder curFolder = folder;

		while (curFolder != null) {
			sb.insert(0, curFolder.getName());
			sb.insert(0, StringPool.SLASH);

			curFolder = curFolder.getParentFolder();
		}

		return sb.toString();
	}

}
