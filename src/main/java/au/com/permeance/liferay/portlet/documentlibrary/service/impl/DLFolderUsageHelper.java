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

package au.com.permeance.liferay.portlet.documentlibrary.service.impl;

import au.com.permeance.liferay.portlet.documentlibrary.model.DLFolderUsage;
import au.com.permeance.liferay.portlet.documentlibrary.model.DLFolderUsageCollector;

import com.liferay.portal.kernel.dao.orm.QueryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portlet.documentlibrary.service.DLAppServiceUtil;

import java.io.IOException;
import java.util.List;


/**
 * Document Library Folder Usage Helper.
 * 
 * @author Tim Telcik <tim.telcik@permeance.com.au>
 */
public class DLFolderUsageHelper {

    private static final Log s_log = LogFactoryUtil.getLog(DLFolderUsageHelper.class);
    
    
    /**
     * Calculate Folder Usage.
     * 
     * @param groupId group id
     * @param repositoryId source repository containing folder to export
     * @param folderId source folder to export
     * @param serviceContext service context
     * 
     * @throws PortalException
     * @throws SystemException
     */
    public static DLFolderUsage calculateFolderUsage(
    		long groupId, long repositoryId, long folderId, ServiceContext serviceContext ) 
    	throws PortalException, SystemException
   	{
    	
    	DLFolderUsage folderUsage = new DLFolderUsage();
    	
    	try {
    		
        	DLFolderUsageCollector folderUsageCollector = new DLFolderUsageCollector();
    		
        	calculateFolderUsage( groupId, repositoryId, folderId, serviceContext, folderUsageCollector );
    		
    		folderUsage = folderUsageCollector.buildFolderUsage();
        	
    	} catch (Exception e) {
    		
            String msg = "Error calculating usage for folder " + folderId 
            		+ " in repository " + repositoryId 
            		+ " : " + e.getMessage();
    		
    		s_log.error( msg, e );
    		
            if (e instanceof PortalException) {
                throw (PortalException) e;

            } else if (e instanceof SystemException) {
                throw (SystemException) e;
            }
    	}
    	
    	return folderUsage;
   	}
    
    	
    /**
     * Visit Folder.
     * 
     * @param groupId group id
     * @param repositoryId source repository containing folder to export
     * @param folderId source folder to export
     * @param serviceContext service context
     * @param folderUsageCollector folder usage collector
     * 
     * @throws PortalException
     * @throws SystemException
     */
    public static void calculateFolderUsage(
    		long groupId, long repositoryId, long folderId, ServiceContext serviceContext, DLFolderUsageCollector folderUsageCollector ) 
    	throws PortalException, SystemException 
    {

        try {

            Folder folder = DLAppServiceUtil.getFolder( folderId );
            
            if (s_log.isDebugEnabled()) {
            	s_log.debug("visit folder " + folder.getFolderId() + "/" + folder.getName());
            }

            calculateFolderUsage( groupId, repositoryId, folder, StringPool.BLANK, serviceContext, folderUsageCollector );

        } catch (Exception e) {

            String msg = "Error visiting folder " + folderId 
            		+ " in repository " + repositoryId 
            		+ " : " + e.getMessage();

            s_log.error(msg, e);

            if (e instanceof PortalException) {
                throw (PortalException) e;

            } else if (e instanceof SystemException) {
                throw (SystemException) e;
            }
        }
    }

    
    /**
     * Visit Folder.
     * 
     * @param groupId group id
     * @param repositoryId source repository containing folder to export
     * @param folder source folder to export
     * @param folderPath source folder path to export
     * @param serviceContext service context
     * @param folderUsageCollector folder usage collector
     * 
     * @throws PortalException 
     * @throws SystemException
     */    
    public static void calculateFolderUsage(
    		long groupId, long repositoryId, Folder folder, String folderPath, ServiceContext serviceContext, DLFolderUsageCollector folderUsageCollector ) 
    	throws PortalException, SystemException 
    {

        // Visit file entries in folder
    	
        if (s_log.isDebugEnabled()) {
        	s_log.debug("visit folder " + folder.getFolderId() + "/" + folder.getName());
        }
    	
        List<FileEntry> fileEntryList = DLAppServiceUtil.getFileEntries(folder.getRepositoryId(), folder.getFolderId(), QueryUtil.ALL_POS,
                QueryUtil.ALL_POS, null);

        for (FileEntry fileEntry : fileEntryList) {
            try {
            	calculateFileEntryUsage( fileEntry, folderPath, folderUsageCollector );
            	folderUsageCollector.incrementFileCount();
            } catch (Exception e) {
            	String msg = "Error visiting file entry " + fileEntry.getFileEntryId() + " : " + e.getMessage();
            	s_log.error(msg, e);
            	throw new PortalException(msg, e);
            }
        }

        
        // Visit sub-folders

        List<Folder> subFolderList = DLAppServiceUtil.getFolders(folder.getRepositoryId(), folder.getFolderId(), QueryUtil.ALL_POS,
                QueryUtil.ALL_POS, null);

        for (Folder subFolder : subFolderList) {
            String subFolderName = subFolder.getName();
            String subFolderPath = folderPath + subFolderName + StringPool.FORWARD_SLASH;
            calculateFolderUsage( groupId, repositoryId, subFolder, subFolderPath, serviceContext, folderUsageCollector );
            folderUsageCollector.incrementFolderCount();
        }
    }
    
    
    /**
     * Visit File Entry.
     *
     * @param fileEntry file entry
     * @param folderPath folder path
     * @param folderUsageCollector folder usage collector
     * 
     * @throws PortalException
     * @throws SystemException
     * @throws IOException
     */
    public static void calculateFileEntryUsage( FileEntry fileEntry, String folderPath, DLFolderUsageCollector folderUsageCollector ) 
    		throws PortalException, SystemException, IOException 
    {
    	
        if (s_log.isDebugEnabled()) {
        	s_log.debug("visit file entry " + fileEntry.getFileEntryId() + "/" + fileEntry.getTitle());
        }
    	
        try {
        	
            long fileEntrySize = fileEntry.getSize();
            
            folderUsageCollector.incrementFolderSize( fileEntrySize );
            
        } catch (Exception e) {

            String msg = "Error visiting file entry " + fileEntry.getFileEntryId() + " : " + e.getMessage();

            s_log.error(msg, e);

            if (e instanceof PortalException) {
                throw (PortalException) e;
                
            } else if (e instanceof SystemException) {
                throw (SystemException) e;
                
            } else if (e instanceof IOException) {
                throw (IOException) e;
            }
            
        } finally {
        }
    }

}
