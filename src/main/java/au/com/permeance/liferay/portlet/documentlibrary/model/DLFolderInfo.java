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

package au.com.permeance.liferay.portlet.documentlibrary.model;

import com.liferay.portal.kernel.util.StringPool;

import java.util.Date;


/**
 * Folder Info.
 * 
 * @author Tim Telcik <tim.telcik@permeance.com.au>
 * 
 * @see DLFolderUsage
 */
public class DLFolderInfo {
	
	private long repositoryId = (-1L);
	
	private String repositoryName = StringPool.BLANK;
	
	private String repositoryClassName = StringPool.BLANK;
	
	private long folderId = (-1L);
	
	private String folderName = StringPool.BLANK;
	
	private String folderDescription = StringPool.BLANK;
	
	private String folderPath = StringPool.BLANK;
	
	private Date folderCreateDate;
	
	private DLFolderUsage folderUsage = new DLFolderUsage();
	
	private long folderUserId = (-1L);
	
	public DLFolderInfo() {
	}

	public long getRepositoryId() {
		return repositoryId;
	}

	public void setRepositoryId(long repositoryId) {
		this.repositoryId = repositoryId;
	}

	public long getFolderId() {
		return folderId;
	}

	public void setFolderId(long folderId) {
		this.folderId = folderId;
	}

	public String getFolderName() {
		return folderName;
	}

	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}

	public Date getFolderCreateDate() {
		return folderCreateDate;
	}

	public void setFolderCreateDate(Date createDate) {
		this.folderCreateDate = createDate;
	}

	public DLFolderUsage getFolderUsage() {
		return folderUsage;
	}

	public void setFolderUsage(DLFolderUsage folderUsage) {
		this.folderUsage = folderUsage;
	}

	public String getFolderDescription() {
		return folderDescription;
	}

	public void setFolderDescription(String folderDescription) {
		this.folderDescription = folderDescription;
	}

	public String getFolderPath() {
		return folderPath;
	}

	public void setFolderPath(String folderLocation) {
		this.folderPath = folderLocation;
	}

	public long getFolderUserId() {
		return folderUserId;
	}

	public void setFolderUserId(long folderUserId) {
		this.folderUserId = folderUserId;
	}

	public String getRepositoryName() {
		return repositoryName;
	}

	public void setRepositoryName(String repositoryName) {
		this.repositoryName = repositoryName;
	}

	public String getRepositoryClassName() {
		return repositoryClassName;
	}

	public void setRepositoryClassName(String repositoryClassName) {
		this.repositoryClassName = repositoryClassName;
	}

	@Override
	public String toString() {
		return "DLFolderInfo [repositoryId=" + repositoryId
				+ ", repositoryName=" + repositoryName
				+ ", repositoryClassName=" + repositoryClassName
				+ ", folderId=" + folderId + ", folderName=" + folderName
				+ ", folderDescription=" + folderDescription + ", folderPath="
				+ folderPath + ", folderCreateDate=" + folderCreateDate
				+ ", folderUsage=" + folderUsage + ", folderUserId="
				+ folderUserId + "]";
	}

}
