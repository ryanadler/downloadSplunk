#
# Bash Shell Script to download the latest Mac tgz release for Splunk enterprise.
#

filename=$(curl 'https://www.splunk.com/en_us/download/splunk-enterprise.html' | grep darwin | perl -lne '/splunk\-\d\.\d\.\d(\.\d\-|\-)\w+\-darwin\-64\.tgz/ && print $&')
version=$(echo $filename | sed 's/splunk-//g' | sed 's/-.*//g')

echo " "
echo " "
wget -O $filename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86&platform=macos&version='$version'&product=splunk&filename='$filename'&wget=true' -q --show-progress
