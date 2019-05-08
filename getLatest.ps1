#This powershell script was written to pull down the latest windows and linux versions of Splunk and Splunk forwarder.
# Author - Ryan Adler

#Checks to see if a file named html is present, and if so, moves it to an .old file. This is a check in case there is a file with the same variable name as this script calls.

$hyper = "html"
if (Test-Path $hyper) {
  echo "There is a file named $hyper within the current directory. This file will be renamed to prevent an error. Please inspect after this script has completed."
  mv $hyper $hyper".old"
}


#Use curl to pull site HTML > html

wget -O html 'https://www.splunk.com/en_us/download/sem.html'

#Use select string to pull Linux version

$linux=cat html | select-string -Pattern "splunk-\d\.\d\.\d\-\w+\-Linux\-x86_64\.tgz" | % { $_.Matches } | % { $_.Value }
$linuxUF=echo $linux | %{$_ -replace "splunk","splunkforwarder"}

echo " "
echo "Linux Forwarder: " $linuxUF
echo " "
echo "Linux Enterprise:   " $linux
echo " "

#Use select string to pull Windows Version

$windows=cat html | select-string -Pattern "splunk-\d\.\d\.\d\-\w+\-x64\-release\.msi" | % { $_.Matches } | % { $_.Value }
$windowsUF=echo $windows | %{$_ -replace "splunk","splunkforwarder"}

echo " "
echo "Windows Forwarder:  " $windowsUF
echo " "
echo "Windows Enterprise:   " $windows
echo " "


#Use Select string to pull build
$build=$linux | select-string "\-(\w+)\-" | % { $_.Matches } | % { $_.Value } | select-string "\w+" | % { $_.Matches } | % { $_.Value }

#use select string to pull version number
$version=$linux | select-string "\d\.\d\.\d" | % { $_.Matches } | % { $_.Value }


#WGET Variable Statements
$wgetWin="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$version&product=splunk&filename=splunk-$version-$build-x64-release.msi&wget=true"
$wgetNix="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$version&product=splunk&filename=splunk-$version-$build-Linux-x86_64.tgz&wget=true"

$wgetWinUF="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$version&product=universalforwarder&filename=splunkforwarder-$version-$build-x64-release.msi&wget=true"
$wgetNixUF="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$version&product=universalforwarder&filename=splunkforwarder-$version-$build-Linux-x86_64.tgz&wget=true"

wget -O $windowsUF "$wgetWinUF"
echo "Windows Forwarder Downloaded"

wget -O $windows "$wgetWin"
echo "Windows Enterprise Downloaded"

echo " "
echo " "

wget -O $linuxUF "$wgetNixUF"
echo "Linux Forwarder Downloaded"

wget -O $linux "$wgetNix"
echo "Linux Enterprise Downloaded"


rm html

echo " "
echo " "
echo "Downloads complete"
echo " "
echo " "
