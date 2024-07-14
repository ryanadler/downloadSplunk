#!/bin/bash

version_list=$(curl -s https://raw.githubusercontent.com/ryanadler/downloadSplunk/main/version.list | grep -v version | grep -v missing | grep -vE "^#")
wget -O splunkDownload.html 'https://www.splunk.com/en_us/download/splunk-enterprise.html' -q
version=$(cat splunkDownload.html | grep -oE "data-link\=\"https://.*data-md5" | head -1 | grep -oE "splunk-.*\"" | sed "s/splunk-//g" | sed "s/-.*//g")
build=$(cat splunkDownload.html | grep -oE "data-link\=\"https://.*data-md5" | head -1 | grep -oE "splunk-.*\"" | grep -oE "[[:digit:]]-\w+-" | sed 's/^[[:digit:]]-//g' | sed 's/-//g')
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
        echo "wget -O splunk-$version-$build.x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build.x86_64.rpm'"
        echo "wget -O splunkforwarder-$version-$build.x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build.x86_64.rpm'"
        echo
	echo 
        echo "-------- Windows --------"
        echo
	echo "-- Binary (MSI)"
        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-x64-release.msi'"
        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-x64-release.msi'"
	echo 
	echo
	echo "-------- Mac --------"
	echo
	echo "-- Tarball (TGZ)"
	echo "wget -O splunk-$version-$build-darwin-64.tgz 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-darwin-64.tgz'"
	echo "wget -O splunkforwarder-$version-$build-darwin-64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-darwin-64.tgz'"
	echo
	echo "-- Intel 10.11 (DMG)"
	echo "wget -O splunk-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-macosx-10.11-intel.dmg'"
	echo "wget -O splunkforwarder-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-macosx-10.11-intel.dmg'"
	echo
	echo
	echo

elif [ $grabLatest = "n" ]; then
        echo "Which version would you like? Example: (8.1.8 or 7.2.10.1)"
        read req_version
	choice=$(echo $version_list | sed 's/ /\n/g' | grep -F "$req_version")

	if [ -z "$choice" ]; then
	echo
	echo "The version you have selected is unavailable for download. Please try again with a different version."
	exit 1
	fi
	
	warn=$(echo $req_version | grep -oE "." | head -1)
	if [ "$warn" -lt "8" ]; then
	clear
	echo
	echo
	echo  -e "\033[33;5m==WARNING==\033[0m"
	echo
	echo "According to Splunk documentation, you are attempting to download an unsupported version of Splunk. If you download this, and then submit a support case for anything other than using this to upgrade to a supported version, that's bad, and you should feel bad. Relevant Docs: https://docs.splunk.com/Documentation/VersionCompatibility/current/Matrix/CompatMatrix .. Please make the right decision to stay on supported versions of Splunk, for Security and Sustainability. And for support sanity."
	echo
	sleep 2
	echo "Would you like to continue? (y/n)"
	read continue
		if [ $continue = "n" ]; then
		exit 1
		fi
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
	echo "wget -O splunk-$version-$build.x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build.x86_64.rpm'"
	echo "wget -O splunkforwarder-$version-$build.x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build.x86_64.rpm'"
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
	echo "-- Intel 10.11 (DMG)"
	echo "wget -O splunk-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/splunk/releases/$version/osx/splunk-$version-$build-macosx-10.11-intel.dmg'"
	echo "wget -O splunkforwarder-$version-$build-macosx-10.11-intel.dmg 'https://download.splunk.com/products/universalforwarder/releases/$version/osx/splunkforwarder-$version-$build-macosx-10.11-intel.dmg'"
	echo
	echo

fi
echo
echo "Thank you, and have a day"
echo
