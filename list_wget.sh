#
# Bash Shell Script to display the different wget statements.
#

html=$(curl 'https://www.splunk.com/goto/Download_4_V1' -s)

nixFilename=$(echo $html | grep Linux-x86_64 | perl -lne '/splunk\-\d\.\d\.\d(\.\d\-|\-)\w+\-Linux\-x86_64\.tgz/ && print $&')
macFilename=$(echo $html | grep darwin | perl -lne '/splunk\-\d\.\d\.\d(\.\d\-|\-)\w+\-darwin\-64\.tgz/ && print $&')
winFilename=$(echo $html | grep release.msi | perl -lne '/splunk\-\d\.\d\.\d(\.\d\-|\-)\w+\-x64\-release\.msi/ && print $&')

version=$(echo $nixFilename | sed 's/splunk-//g' | sed 's/-.*//g')
nixFW=$(echo $nixFilename | sed 's/splunk/splunkforwarder/g')
winFW=$(echo $winFilename | sed 's/splunk/splunkforwadrer/g')

echo " "
echo " "
echo " Linux: " $nixFilename
echo " "
echo " Mac: " $macFilename
echo " "
echo " Windows: " $winFilename
echo " "
echo " "
echo "==== Linux WGET Statements ===="
echo wget -O $nixFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=splunk&filename='$nixFilename'&wget=true' -q --show-progress
echo " "
echo wget -O $nixFW 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=universalforwarder&filename='$nixFW'&wget=true' -q --show-progress
echo " "
echo " "
echo "==== Mac WGET Statement ====" 
echo wget -O $macFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86&platform=macos&version='$version'&product=splunk&filename='$macFilename'&wget=true' -q --show-progress
echo " "
echo " "
echo "==== Windows WGET Statements ===="
echo wget -O $winFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version='$version'&product=splunk&filename='$winFilename'&wget=true'
echo " "
echo wget -O $winFW 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version='$version'&product=universalforwarder&filename='$winFW'&wget=true'

echo " "
echo "Complete"


