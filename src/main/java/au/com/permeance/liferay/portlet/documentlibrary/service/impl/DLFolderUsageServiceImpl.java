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
import au.com.permeance.liferay.portlet.documentlibrary.service.DLFolderUsageService;
import au.com.permeance.liferay.portlet.documentlibrary.service.DLFolderUsageServiceUtil;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.service.ServiceContext;


/**
 * Document Library Folder Usage Service Implementation.
 * 
 * @author Tim Telcik <tim.telcik@permeance.com.au>
 * 
 * @see DLFolderUsageService
 * @see DLFolderUsageServiceUtil
 * @see DLFolderUsageHelper
 */
public class DLFolderUsageServiceImpl implements DLFolderUsageService {

    public DLFolderUsage calculateFolderUsage(
    		long groupId, long repositoryId, long folderId, ServiceContext serviceContext)
    	throws PortalException, SystemException 
    {
    	return DLFolderUsageHelper.calculateFolderUsage( groupId, repositoryId, folderId, serviceContext );
    }
    
}
