#!/bin/bash

#
# Bash Shell Script to download the latest Linux ARM tgz release for Splunks universal forwarder
#

filename=$(curl 'https://www.splunk.com/en_us/download/previous-releases/universalforwarder.html' | grep Linux-arm | perl -lne '/splunkforwarder\-\d\.\d\.\d(\.\d\-|\-)\w+\-Linux\-arm\.tgz/ && print $&' | head -n 5 | sort -gr | head -n 1)
version=$(echo $filename | sed 's/splunkforwarder-//g' | sed 's/-.*//g')


echo " "
wget -O $filename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=ARM&platform=linux&version='$version'&product=universalforwarder&filename='$filename'&wget=true' -q --show-progress
echo "$fwinstall downloaded"
echo " "
echo " Complete "
