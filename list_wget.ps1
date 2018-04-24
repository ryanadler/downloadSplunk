#
# PowerShell Script to display the different wget statements.
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
$nix1="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$version&product=splunk&filename=$nixFilename&wget=true"
$nix2="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$version&product=universalforwarder&filename=$nixFW&wget=true"
echo "wget -O $nixFilename "$nix1""
echo " "
echo "wget -O $nixFW "$nix2""
echo " "
echo " "
echo "==== Mac WGET Statement ===="
$mac1="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86&platform=macos&version=$version&product=splunk&filename=$macFilename&wget=true" 
echo "wget -O $macFilename "$mac1""
echo " "
echo " "
echo "==== Windows WGET Statements ===="
$win1="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$version&product=splunk&filename=$winFilename&wget=true"
$win2="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$version&product=universalforwarder&filename=$winFW&wget=true"
echo "wget -O $winFilename "$win1""
echo " "
echo "wget -O $winFW "$win2""

echo " "
echo "Complete"


