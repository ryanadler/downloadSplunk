#!/bin/bash

wget -O splunkDownload.html 'https://www.splunk.com/en_us/download/splunk-enterprise.html' -q
base=$(cat splunkDownload.html | grep -oE "splunk\-[[:digit:]].*linux-2.6-x86_64.rpm\" data-link" | sed 's/\".*//g' | head -1)
version=$(echo $base | grep -oe "\([[:digit:]]\.[[:digit:]]\.[[:digit:]]\.[[:digit:]]\|[[:digit:]]\.[[:digit:]]\.[[:digit:]]\)")
build=$(echo $base | grep -oe "\w\{7,\}")

wget -O olderVersions.list 'https://www.splunk.com/page/previous_releases'

echo 
echo "Checking Version Pages and Filling in Any Gaps"
echo 
cat olderVersions.list| grep -oE "data-filename=\"splunk-.*-.*-linux\-2.6-x86_64.rpm" | sed 's/\" data-link.*//g' | sed 's/data-filename=\"splunk-//g' | sed 's/-linux.*//g' | sed 's/\-/,/g' >> version.list 
echo "version,build" >> new.list
cat version.list | grep -v "version\,build" | sort | uniq >> new.list
echo "$version,$build" >> new.list

echo
echo "Cleaning Up"
rm -f olderVersions.list
rm -f version.list
mv new.list version.list
rm -f splunkDownload.html

echo
echo "Update Complete"
echo
