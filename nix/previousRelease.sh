#
# Bash Shell Script to download a non-latest version of the Mac tgz release for Splunk enterprise.
#

echo
latest=$(curl -s 'https://www.splunk.com/en_us/download/sem.html' | grep Linux-x86_64 | perl -lne '/splunk\-\d\.\d\.\d(\.\d\-|\-)\w+\-Linux\-x86_64\.tgz/ && print $&')
echo
echo "The latest Linux release:"
echo
echo $latest
echo
echo "Please enter a previous release to download. Example: 7.3.4"
echo
read version
filename=$(curl -s 'https://www.splunk.com/page/previous_releases' | grep Linux-x86_64 | perl -lne '/splunk\-'$version'\-\w+\-Linux\-x86_64\.tgz/ && print $&')
echo
echo "Downloading Enterprise Installation"
echo
wget -O $filename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=splunk&filename='$filename'&wget=true' -q --show-progress
echo
echo "Downloading Forwarder Installation"
echo
fw=$(echo $filename | sed 's/splunk/splunkforwarder/g')
wget -O $fw 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=universalforwarder&filename='$fw'&wget=true' -q --show-progress
echo
echo " Complete "
echo
