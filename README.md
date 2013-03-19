# Liferay Documents and Media Info Viewer

*liferay-dm-info-viewer*

This project provides a Liferay Portal plugin to quickly view information about Document and Media folders (eg. total sub-folders and files, total file size). 
The view is similar to MS Windows File Explorer Properties and Apple Mac OS X Finder Info views.


## Supported Products

* Liferay Portal 6.1 CE GA2 (6.1.1+)
* Liferay Portal 6.1 EE GA2 (6.1.20+)


## Downloads

TODO


## Usage

Step 1. Navigate to Liferay Portal page containing Documents and Media portlet.

Step 2. Click on the "Action" button for a folder and select the "Show Info" menu item.

Step 3. View info and click "OK" button to close popup.


## Building

Step 1. Checkout source from GitHub project

    % git  clone  https://github.com/permeance/liferay-dm-info-viewer

Step 2. Build and package

    % mvn  -U  clean  package

This will build "liferay-dm-info-viewer-hook-XXX.war" in the targets tolder.

NOTE: You will require JDK 1.6+ and Maven 3.


## Installation

### Liferay Portal + Apache Tomcat Bundle

Deploy "liferay-dm-info-viewer-hook-1.0.0.0.war" to "LIFERAY_HOME/deploy" folder.


## Project Team

* Tim Telcik - tim.telcik@permeance.com.au

