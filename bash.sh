#!/bin/bash

version_list=$(curl -s https://raw.githubusercontent.com/ryanadler/downloadSplunk/main/version.list | grep -v version | grep -v missing)
wget -O splunkDownload.html 'https://www.splunk.com/en_us/download/splunk-enterprise.html' -q
base=$(grep -oE "splunk\-\d.*?\.rpm" splunkDownload.html| head -1)
version=$(echo $base | grep -oe "\(\d\.\d\.\d\|\d\.\d\.\d\.\d\)")
build=$(echo $base | grep -oe "\w\{7,\}")
rm splunkDownload.html

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
        echo "-------- Linux Tarball (TGZ) --------"
        echo
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
        echo
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
        echo

        echo "-------- RHEL Package Manager (RPM) --------"
        echo
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
        echo
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
        echo

        echo "-------- Windows Installation (MSI) --------"
        echo
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-x64-release.msi'"
        echo
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-x64-release.msi'"
fi
#elif [ $grabLatest = "n" ]; then
#        echo "Which version would you like? (example 8.1.7.2)"
#        read req_version
#        version=$(curl 'https://www.splunk.com/en_us/download/previous-releases.html' | grep -oE "splunk\-$req_version\-.*?64.rpm" | head -1 | sed 's/splunk\-//g' | sed 's/\-.*//g')
#        build=$(curl 'https://www.splunk.com/en_us/download/previous-releases.html' | grep -oE "splunk\-$req_version\-.*?64.rpm" | head -1 | grep -oe "\w\{7,\}")
#
#        if [ -z "$version" ]; then
#        echo
#        echo "The version you entered is not valid, please run again."
#        exit 1
#        fi
#
#        echo
#        echo "Displaying WGET Statements for Splunk:
#        Version: $version
#        Build: $build"
#
#        echo
#        echo "-------- Linux Tarball (TGZ) --------"
#        echo
#        echo "Enterprise:"
#        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
#        echo
#        echo "Splunk Forwarder:"
#        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
#        echo
#
#        echo "-------- RHEL Package Manager (RPM) --------"
#        echo
#        echo "Enterprise:"
#        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
#        echo
#        echo "Splunk Forwarder:"
#        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
#        echo
#
#        echo "-------- Windows Installation (MSI) --------"
#        echo
#        echo "Enterprise:"
#        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-x64-release.msi'"
#        echo
#        echo "Splunk Forwarder:"
#        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-x64-release.msi'"
#fi
#echo
#echo "Thank you, and have a day"
#echo
