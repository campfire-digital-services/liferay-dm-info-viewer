# Liferay Documents and Media Info Viewer

*liferay-dm-info-viewer*

This project provides a Liferay Portal plugin to quickly view information about Document and Media folders (eg. total sub-folders and files, total file size).

The view is similar to MS Windows File Explorer Properties and Apple Mac OS X Finder Info views.


## Supported Products

* Liferay Portal 6.1 CE GA2 (6.1.1+)
* Liferay Portal 6.1 EE GA2 (6.1.20+)


## Downloads

The latest release is available from [SourceForge - Liferay Documents and Media Info Viewer](https://sourceforge.net/projects/permeance-apps/files/liferay-documents-and-media-info-viewer/releases/ "SourceForge - Liferay Documents and Media Info Viewer").


## Usage

### Browse Local Repository

Step 1. Navigate to Liferay Portal page containing Documents and Media portlet.

![Documents and Media Portlet](/docs/images/local-repos/liferay-dm-portlet-local-repos-root-folder-view-20130209.png "Documents and Media Portlet")

Step 2. Click on the "Action" button for a folder in local repository and select the "Show Info" menu item.

![Documents and Media Folder Action Menu](/docs/images/common/liferay-dm-portlet-folder-info-action-menu-20130319T0043.png "Documents and Media Folder Action Menu")

Step 3. View info and click "close" icon to close popup.

![Documents and Media Folder Info Popup (Local Repository)](/docs/images/local-repos/liferay-dm-portlet-folder-info-popup-local-repos-20130330T2101.jpg "Documents and Media Folder Info Popup (Local Repository)")

### Browse Remote Repository (CMIS AtomPub)

Step 1. Navigate to remote repository (CMIS AtomPub) using Documents and Media portlet.

![Documents and Media Portlet](/docs/images/remote-repos/cmis-alfresco/liferay-dm-portlet-remote-repos-cmis-atompub-alfresco-root-folder-view-20130330T2014.jpg "Documents and Media Portlet")

Step 2. Click on the "Action" button for a folder in remote repository (CMIS AtomPub) and select the "Show Info" menu item.

![Documents and Media Folder Action Menu](/docs/images/common/liferay-dm-portlet-folder-info-action-menu-20130319T0043.png "Documents and Media Folder Action Menu")

Step 3. View info and click "close" icon to close popup.

![Documents and Media Remote Repository Folder (CMIS AtomPub)](/docs/images/remote-repos/cmis-alfresco/liferay-dm-portlet-folder-info-popup-remote-repos-cmis-atompub-alfresco-20130330T2101.jpg "Documents and Media Remote Repository Folder (CMIS AtomPub)")


## Building

Step 1. Checkout source from GitHub project

    % git clone https://github.com/permeance/liferay-dm-info-viewer

Step 2. Build and package

    % mvn -U clean package

This will build "liferay-dm-info-viewer-hook-XXX.war" in the targets tolder.

NOTE: You will require JDK 1.6+ and Maven 3.


## Installation

### Liferay Portal + Apache Tomcat Bundle

* Deploy "liferay-dm-info-viewer-hook-1.0.0.0.war" to "LIFERAY_HOME/deploy" folder.


## Project Team

* Tim Telcik - tim.telcik@permeance.com.au


## Related Projects

* [GitHub - Sample Liferay Documents and Media Action Menu Extension](https://github.com/permeance/sample-liferay-dm-action-menu-extension "GitHub - Sample Liferay Documents and Media Action Menu Extension").
