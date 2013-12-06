# Liferay Documents and Media Info Viewer

*liferay-dm-info-viewer*

This project provides a Liferay Portal plugin to quickly view information about Document and Media folders (eg. total sub-folders and files, total file size).

The view is similar to MS Windows File Explorer Properties and Apple Mac OS X Finder Info views.


## Supported Products

### GitHub Project Master and Branch 6.2.x

* Liferay Portal 6.2 CE : 6.2 CE GA1 (6.2.0+)
* Liferay Portal 6.2 EE : 6.2 EE GA1 (6.2.10+)

### GitHub Project Branch 6.1.x

* Liferay Portal 6.1 CE : 6.1 CE GA2, GA3 (6.1.1+)
* Liferay Portal 6.1 CE : 6.1 EE GA2, GA3 (6.1.20+)


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

Step 1.1. Checkout master from GitHub project

    NOTE: GitHub master and branch 6.2.x should always be the same.

    $ md work
    $ cd work
    $ md master
    $ git clone https://github.com/permeance/liferay-dm-info-viewer
    Cloning into 'liferay-dm-info-viewer'...
    remote: Counting objects: 518, done.
    remote: Compressing objects: 100% (223/223), done.
    remote: Total 518 (delta 173), reused 502 (delta 157)
    Receiving objects: 100% (518/518), 622.65 KiB | 273.00 KiB/s, done.
    Resolving deltas: 100% (173/173), done.
    Checking connectivity... done

Step 1.2. Checkout branch 6.1.x or 6.2.x from GitHub project

    NOTE: This sample shows checkout for branch 6.2.x. 
          The same process applies for 6.1.x

    % md work
    % cd work
    % md -p liferay-dm-info-viewer/branches/6.2.x
    % cd liferay-dm-info-viewer/branches/6.2.x
    % git clone https://github.com/permeance/liferay-dm-info-viewer
    Cloning into 'liferay-dm-info-viewer'...
    remote: Counting objects: 475, done.
    remote: Compressing objects: 100% (199/199), done.
    remote: Total 475 (delta 151), reused 470 (delta 146)
    Receiving objects: 100% (475/475), 618.21 KiB | 161.00 KiB/s, done.
    Resolving deltas: 100% (151/151), done.
    Checking connectivity... done
    % cd liferay-dm-info-viewer
    % git branch 6.2.x
    % git checkout 6.2.x
    Switched to branch '6.2.x'
    % git status
    # On branch 6.2.x
    nothing to commit, working directory clean

Step 2. Build and package

    % mvn -U clean package

This will build "liferay-dm-info-viewer-hook-A.B.C.war" in the targets tolder.

NOTE: You will require JDK 1.6+ and Maven 3.


## Installation

### Liferay Portal + Apache Tomcat Bundle

* Deploy "liferay-dm-info-viewer-hook-A.B.C.war" to "LIFERAY_HOME/deploy" folder.


## Project Team

* Tim Telcik - tim.telcik@permeance.com.au


## Related Projects

* [GitHub - Sample Liferay Documents and Media Action Menu Extension](https://github.com/permeance/sample-liferay-dm-action-menu-extension "GitHub - Sample Liferay Documents and Media Action Menu Extension").
