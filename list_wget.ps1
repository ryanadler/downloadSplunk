#
# Sometimes you just need a script to show you the wget script
#

$html=curl 'https://www.splunk.com/goto/Download_4_V1'

$nixFilename=echo $html | select-string -Pattern "splunk\-\d\.\d\.\d\-\w+\-Linux\-x86_64\.tgz" |  % { $_.Matches } | % { $_.Value}
$macFilename=echo $html | select-string -Pattern "splunk\-\d\.\d\.\d\-\w+\-darwin\-64\.tgz" | % { $_.Matches } | % { $_.Value}
$winFilename=echo $html | select-string -Pattern "splunk-\d\.\d\.\d\-\w+\-x64\-release\.msi" | % { $_.Matches } | % { $_.Value}

$version=$winFilename | select-string "\d\.\d\.\d" | % {$_.Matches } | % {$_.Value }
$nixFW=echo $nixFilename | %{$_ -replace "splunk","splunkforwarder"}
$winFW=echo $winFilename | %{$_ -replace "splunk","splunkforwarder"}

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
echo wget -O $filename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=splunk&filename='$nixFilename'&wget=true'
echo " "
echo wget -O $nixFW 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version='$version'&product=universalforwarder&filename='$nixFW'&wget=true'
echo " "
echo " "
echo "==== Mac WGET Statement ====" 
echo wget -O $macFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86&platform=macos&version='$version'&product=splunk&filename='$macFilename'&wget=true'
echo " "
echo " "
echo "==== Windows WGET Statements ===="
echo wget -O $winFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version='$version'&product=splunk&filename='$winFilename'&wget=true'
echo " "
echo wget -O $winFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version='$version'&product=universalforwarder&filename='$winFW'&wget=true'

echo " "
echo "Complete"


