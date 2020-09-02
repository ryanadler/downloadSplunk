#
# Bash Shell Script to download a non-latest version of the Mac tgz release for Splunk enterprise.
#

echo
latest=$(curl 'https://www.splunk.com/en_us/download/sem.html' | grep darwin | perl -lne '/splunk\-\d\.\d\.\d(\.\d\-|\-)\w+\-darwin\-64\.tgz/ && print $&')
echo "The latest Mac release:"
echo
echo $latest
echo
echo "Please enter a non-latest version release to download. Example: 7.3.4"
echo
read version
echo $version
echo
filename=$(wget 'https://www.splunk.com/page/previous_releases' && cat previous_releases | grep darwin | perl -lne "/splunk\-\d\.\d\.\d\-\w+\-darwin\-64\.tgz/ && print $&" | grep "7.3.4")
echo $filename
rm previous_releases
echo
wget -O $filename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86&platform=macos&version='$version'&product=splunk&filename='$filename'&wget=true' -q --show-progress
