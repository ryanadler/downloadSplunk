#!/bin/bash

wget -O splunkDownload.html 'https://www.splunk.com/en_us/download/splunk-enterprise.html' -q
version=$(cat splunkDownload.html | grep -oE "data-link\=\"https://.*data-md5" | head -1 | grep -oE "splunk-.*\"" | sed "s/splunk-//g" | sed "s/-.*//g")
build=$(cat splunkDownload.html | grep -oE "data-link\=\"https://.*data-md5" | head -1 | grep -oE "splunk-.*\"" | grep -oE "[[:digit:]]-\w+-" | sed 's/^[[:digit:]]-//g' | sed 's/-//g')

wget -O olderVersions.list 'https://www.splunk.com/en_us/download/previous-releases.html?locale=en_us'


echo 
echo "Checking Version Pages and Filling in Any Gaps"
echo 
#cat olderVersions.list| grep -oE "data-filename=\"splunk-.*-.*-linux\-2.6-x86_64.rpm" | sed 's/\" data-link.*//g' | sed 's/data-filename=\"splunk-//g' | sed 's/-linux.*//g' | sed 's/\-/,/g' >> version.list 
cat olderVersions.list | grep -oE "data-filename=\"splunk-.*\" data-link" | sort | uniq | sed 's/data-filename=\"splunk-//g' | grep rpm | sed 's/-linux.*//g' | sed 's/\.x86.*//g' | sed 's/-/,/g' >> version.list
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
