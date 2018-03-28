#
#PowerShell script to pull down the latest windows versions of Splunk Enterprise, and Forwarder

#use select string to pull version

$win=curl 'https://www.splunk.com/goto/Download_4_V1' | select-string -Pattern "splunk-\d\.\d\.\d\-\w+\-x64\-release\.msi" | % { $_.Matches } | % { $_.Value}
$uf=echo $win | %{$_ -replace "splunk","splunkforwarder"}

echo " "
echo " "

#Grab Build
$build=$win | select-string "\-(\w+)\-" | % { $_.Matches } | % {$_.Value} | select-string "\w+" | % { $_.Matches } | % { $_.Value }

#Grab Version
$version=$win | select-string "\d\.\d\.\d" | % {$_.Matches } | % {$_.Value }

#WGET statements

$wgetEnt="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$version&product=splunk&filename=splunk-$version-$build-x64-release.msi&wget=true"

$wgetUF="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$version&product=universalforwarder&filename=splunkforwarder-$version-$build-x64-release.msi&wget=true"

#Grab Files

wget -O $uf "$wgetUF"

echo " "
echo " Forwarder Download Complete "
echo " "

wget -O $win "$wgetEnt"

echo " "
echo " Enterprise Download Complete "
echo " "

rm html

