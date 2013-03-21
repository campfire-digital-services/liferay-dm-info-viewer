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


/**
 * Folder Usage.
 * 
 * @author Tim Telcik <tim.telcik@permeance.com.au>
 */
public class DLFolderUsage {
	
	private long folderSize = 0L;
	private long folderCount = 0L;
	private long fileCount = 0L;
	
	
	public DLFolderUsage() {
	}

	public long getFolderSize() {
		return folderSize;
	}

	public void setFolderSize(long folderSize) {
		this.folderSize = folderSize;
	}

	public long getFolderCount() {
		return folderCount;
	}

	public void setFolderCount(long folderCount) {
		this.folderCount = folderCount;
	}

	public long getFileCount() {
		return fileCount;
	}

	public void setFileCount(long fileCount) {
		this.fileCount = fileCount;
	}

	@Override
	public String toString() {
		return "DLFolderUsage [folderSize=" + folderSize + ", folderCount="
				+ folderCount + ", fileCount=" + fileCount + "]";
	}

}
