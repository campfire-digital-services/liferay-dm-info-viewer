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
package au.com.permeance.liferay.portlet.util;

import au.com.permeance.liferay.portlet.kernel.util.FolderInfoPropsKeys;

import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.StringUtil;


/**
 * Hook Property Values.
 * 
 * @author Tim Telcik <tim.telcik@permeance.com.au>
 * 
 * @see FolderInfoPropsKeys
 */
public class FolderInfoPropsValues {
	
	public static String DEFAULT_DL_FOLDER_INFO_ACTIONS_MENU_EXT = "show_info";
	
	public static String DEFAULT_DL_FOLDER_INFO_SERVLET_CONTEXT_NAME = "liferay-dm-info-viewer-hook";
	
	public static String[] DL_FOLDER_INFO_ACTIONS_MENU_EXT 
		= StringUtil.split(
				GetterUtil.get(PropsUtil.get(FolderInfoPropsKeys.DL_FOLDER_INFO_ACTIONS_MENU_EXT),DEFAULT_DL_FOLDER_INFO_ACTIONS_MENU_EXT));
	
    public static final String DL_FOLDER_INFO_SERVLET_CONTEXT_NAME 
    	= GetterUtil.getString(PropsUtil.get(FolderInfoPropsKeys.DL_FOLDER_INFO_SERVLET_CONTEXT_NAME),DEFAULT_DL_FOLDER_INFO_SERVLET_CONTEXT_NAME);    
    
}
