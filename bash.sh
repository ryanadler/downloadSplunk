#!/bin/bash

version_list=$(curl -s https://raw.githubusercontent.com/ryanadler/downloadSplunk/main/version.list | grep -v version | grep -v missing)
wget -O splunkDownload.html 'https://www.splunk.com/en_us/download/splunk-enterprise.html' -q
base=$(grep -oE "splunk\-\d.*?\.rpm" splunkDownload.html| head -1)
version=$(echo $base | grep -oe "\(\d\.\d\.\d\|\d\.\d\.\d\.\d\)")
build=$(echo $base | grep -oe "\w\{7,\}")
rm splunkDownload.html
clear
# Engage with the User
echo
echo
echo "Welcome To The Splunk Download Script."
echo
echo "The Latest Release Of Splunk is: 
Version: $version 
Build: $build"
echo
echo "Would you like WGET statements for the latest version? (y/n)"
read grabLatest
if [ -z "$grabLatest" ]; then
        grabLatest="y"
fi

if [ $grabLatest = "y" ]; then
        echo
        echo "Displaying WGET Statements for Splunk:
        Version: $version
        Build: $build"

        echo
        echo "-------- Linux --------"
        echo
	echo "-- Tarball (TGZ)"
        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
	echo 
	echo "-- Debian (DEB)"
	echo "wget -O splunk-$version-$build-linux-2.6-amd64.deb 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-amd64.deb'"
	echo "wget -O splunkforwarder-$version-$build-linux-2.6-amd64.deb 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-amd64.deb'"
	echo
	echo "-- RHEL (RPM)"
        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
        echo
	echo 
        echo "-------- Windows --------"
        echo
	echo "-- Binary (MSI)"
        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-x64-release.msi'"
        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-x64-release.msi'"
	echo 
	echo "-- ZIP"
	echo "wget -O splunk-$version-$build-windows-64.zip 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-windows-64.zip'"
	echo "wget -O splunkforwarder-$version-$build-windows-64.zip 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-windows-64.zip'"
	echo
	echo
	echo "-------- Mac --------"
	echo
	echo "-- Tarball (TGZ)"
	echo "wget -O splunk-$version-$build-darwin-64.tgz 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-darwin-64.tgz'"
	echo "wget -O splunkforwarder-$version-$build-darwin-64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-darwin-64.tgz'"
	echo
	echo "-- Intel (DMG)"
	echo "wget -O splunk-$version-$build-macosx-intel.dmg 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-macosx-intel.dmg'"
	echo "wget -O splunkforwarder-$version-$build-macosx-intel.dmg 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-macosx-intel.dmg'"
	echo
	echo "-- Intel 10.11 (DMG)"
	echo "wget -O splunk-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-macosx-10.11-intel.dmg'"
	echo "wget -O splunkforwarder-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-macosx-10.11-intel.dmg'"

elif [ $grabLatest = "n" ]; then
        echo "Which version would you like? Example: (8.1.8 or 7.2.10.1)"
        read req_version
	choice=$(echo $version_list | grep "$req_version")

        if [ -z "$choice" ]; then
        echo
        echo "The version you have selected is unavailable for download. Please try again with a different version."
        exit 1
        fi

	version=$(echo $choice | sed 's/,.*//g')
	build=$(echo $choice | sed 's/.*,//g')
        
	echo
	echo "Displaying WGET Statements for Splunk:
        Version: $version
        Build: $build"

        echo
        echo "-------- Linux --------"
        echo
        echo "-- Tarball (TGZ)"
        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
        echo
        echo "-- Debian (DEB)"
        echo "wget -O splunk-$version-$build-linux-2.6-amd64.deb 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-amd64.deb'"
        echo "wget -O splunkforwarder-$version-$build-linux-2.6-amd64.deb 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-amd64.deb'"
        echo
        echo "-- RHEL (RPM)"
        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
        echo
        echo
        echo "-------- Windows --------"
        echo
        echo "-- Binary (MSI)"
        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-x64-release.msi'"
        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-x64-release.msi'"
        echo
        echo "-- ZIP"
        echo "wget -O splunk-$version-$build-windows-64.zip 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-windows-64.zip'"
        echo "wget -O splunkforwarder-$version-$build-windows-64.zip 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-windows-64.zip'"
        echo
        echo
        echo "-------- Mac --------"
        echo
        echo "-- Tarball (TGZ)"
        echo "wget -O splunk-$version-$build-darwin-64.tgz 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-darwin-64.tgz'"
        echo "wget -O splunkforwarder-$version-$build-darwin-64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-darwin-64.tgz'"
        echo
        echo "-- Intel (DMG)"
        echo "wget -O splunk-$version-$build-macosx-intel.dmg 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-macosx-intel.dmg'"
        echo "wget -O splunkforwarder-$version-$build-macosx-intel.dmg 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-macosx-intel.dmg'"
        echo
        echo "-- Intel 10.11 (DMG)"
        echo "wget -O splunk-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-macosx-10.11-intel.dmg'"
        echo "wget -O splunkforwarder-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-macosx-10.11-intel.dmg'"

fi
echo
echo "Thank you, and have a day"
echo
