#!/bin/bash

#
# Bash Shell Script to download the latest Linux 64bit tgz release for Splunk enterprise and universal forwarder
#

filename=$(curl 'https://www.splunk.com/en_us/download/sem.html' | grep Linux-x86_64 | perl -lne '/splunk\-\d\.\d\.\d(\.\d\-|\-)\w+\-Linux\-x86_64\.tgz/ && print $&')
version=$(echo $filename | sed 's/splunk-//g' | sed 's/-.*//g')
fw=$(echo $filename | sed 's/splunk/splunkforwarder/g')


echo " "
wget -O $filename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=splunk&filename='$filename'&wget=true' -q --show-progress
echo "$reginstall downloaded"
echo " "
wget -O $fw 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=universalforwarder&filename='$fw'&wget=true' -q --show-progress
echo "$fwinstall downloaded"
echo " "
echo " Complete "
