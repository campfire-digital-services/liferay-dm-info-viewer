# Liferay Documents and Media Info Viewer

*liferay-dm-info-viewer*

This project provides a Liferay Portal plugin to quickly view information about Document and Media folders (eg. total sub-folders and files, total file size). 
The view is similar to MS Windows File Explorer Properties and Apple Mac OS X Finder Info views.


## Supported Products

* Liferay Portal 6.1 CE GA2 (6.1.1+)
* Liferay Portal 6.1 EE GA2 (6.1.20+)


## Downloads

The latest releases are available from [SourceForge](https://sourceforge.net/projects/permeance-apps/files/liferay-documents-and-media-info-viewer/releases/ "Liferay Documents and Media Info Viewer").


## Usage

Step 1. Navigate to Liferay Portal page containing Documents and Media portlet.

![Documents and Media Portlet](/docs/images/liferay-dm-portlet-root-folder-view-20130209.png "Documents an Media Portlet")

Step 2. Click on the "Action" button for a folder and select the "Show Info" menu item.

![Documents and Media Folder Action Menu](/docs/images/liferay-dm-portlet-folder-info-action-menu-20130319T0043.png "Documents an Media Folder Action Menu")

Step 3. View info and click "OK" button to close popup.

![Documents and Media Folder Info Popup](/docs/images/liferay-dm-portlet-folder-info-popup-local-repos-20130325T1558.jpg "Documents an Media Folder Info Popup")


## Building

Step 1. Checkout source from GitHub project

    % git clone https://github.com/permeance/liferay-dm-info-viewer

Step 2. Build and package

    % mvn -U clean package

This will build "liferay-dm-info-viewer-hook-XXX.war" in the targets tolder.

NOTE: You will require JDK 1.6+ and Maven 3.


## Installation

### Liferay Portal + Apache Tomcat Bundle

Deploy "liferay-dm-info-viewer-hook-1.0.0.0.war" to "LIFERAY_HOME/deploy" folder.


## Project Team

* Tim Telcik - tim.telcik@permeance.com.au

