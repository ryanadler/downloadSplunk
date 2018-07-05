#test

#
# Powershell to list the different wget version statements (version 7.0.x)
#
#pull down HTML to sort through
wget -O html 'https://www.splunk.com/en_us/download/sem-os.html'

echo " "
echo " The following 7.0.x versions are available for download: "
echo " "

cat html | select-string -Pattern "7\.0\.\d" | % { $_.Matches } | % { $_.Value} | Select-Object -unique

# Input
echo " "
echo "Select which version of Splunk to download"
echo "For example, 7.0.4"
echo " "

$req = Read-host
#$req="7.0.4"


#########				##########
#########  Enterprise	##########
#########				########## 

#pull filenames for enterprise installs
$enterprise = cat html | select-string -Pattern "splunk-$req-.*?(x64|x86_64).*?\.(msi|tgz)" | % { $_.Matches } | % { $_.Value}

$build=$enterprise | select-string "\-(\w+)\-" | % { $_.Matches } | % { $_.Value } | select-string "\w+" | % { $_.Matches } | % { $_.Value } | Select-Object -unique

#use select string to pull version number
$version=$enterprise | select-string "\d\.\d\.\d" | % { $_.Matches } | % { $_.Value } | Select-Object -unique


#########		  ##########
#########  Linux  ##########
#########		  ########## 

echo " "
echo "Downloading Linux Version"
echo " "

cat html | select-string -Pattern "splunk-$req-.*?(x64|x86_64).*?\.(tgz)" | % { $_.Matches } | % { $_.Value}
$linux = cat html | select-string -Pattern "splunk-$req-.*?(x64|x86_64).*?\.(tgz)" | % { $_.Matches } | % { $_.Value}

echo " "
echo " "

#WGET Variable Statements
$wgetNix="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$version&product=splunk&filename=splunk-$version-$build-Linux-x86_64.tgz&wget=true"

wget -O $linux "$wgetNix"
echo " "
echo "Linux Enterprise Downloaded"

#########		    ##########
#########  Windows  ##########
#########		    ########## 

echo " "
echo "Downloading Windows Version"
echo " "

cat html | select-string -Pattern "splunk-$req-.*?(x64|x86_64).*?\.(msi)" | % { $_.Matches } | % { $_.Value}
$windows = cat html | select-string -Pattern "splunk-$req-.*?(x64|x86_64).*?\.(msi)" | % { $_.Matches } | % { $_.Value}

#WGET Variable Statements
$wgetWin="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$version&product=splunk&filename=splunk-$version-$build-x64-release.msi&wget=true"

wget -O $windows "$wgetWin"
echo " "
echo "Windows Enterprise Downloaded"

rm html