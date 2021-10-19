# Clear Screen
clear
# Grab the Latest Splunk versions and Variables
wget -O splunkDownload.html 'https://www.splunk.com/en_us/download/splunk-enterprise.html'
$html=cat splunkDownload.html
$nixtgzFilename=$html | Select-String -Pattern "splunk\-\d.*?Linux\-x86_64\.tgz" |  % { $_.Matches } | % { $_.Value}
$nixrpmFilename=$html | Select-String -Pattern "splunk\-\d.*?\.rpm" |  % { $_.Matches } | % { $_.Value}
$winFilename=$html | select-string -Pattern "splunk\-\d.*?\-x64\-release\.msi" | % { $_.Matches } | % { $_.Value}
$version=$nixtgzFilename | %{$_ -replace "splunk-",""} | %{$_ -replace "\-.*",""}
$build=$nixtgzFilename | %{$_ -replace "splunk-.*?\-",""}  | %{$_ -replace "\-.*",""}
rm splunkDownload.html
# Engage with the User
echo ""
echo ""
echo "Welcome To The Splunk Download Script."
echo ""
echo "The Latest Release Of Splunk is: 
Version: $version 
Build: $build"
echo ""
$grabLatest = Read-Host "Would you like WGET statements for the Latest Version? (y/n)"
if ([string]::IsNullOrWhiteSpace($grabLatest))
{ $grabLatest = "y" }
echo ""
if ($grabLatest -eq 'y')
{       
        echo ""
        echo "Displaying WGET Statements for Splunk:
        Version: $version
        Build: $build"
    
        echo ""
        echo "-------- Linux Tarball (TGZ) "
        echo ""
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
        echo ""
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
        echo ""

        echo "-------- RHEL Package Manager (RPM) "
        echo ""
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
        echo ""
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
        echo ""

        echo "-------- Windows Installation (MSI) "
        echo ""
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-x64-release.msi'"
        echo ""
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-x64-release.msi'"
}

if ($grabLatest -eq 'n')
{
    $html=curl 'https://www.splunk.com/page/previous_releases' 
    $req_version = Read-Host "Which Version Would You Like? (example: 7.2.10.1 or 8.1.6)"
    $version=$html | select-string -Pattern "splunk-$req_version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique | %{$_ -replace "splunk\-", ""} | %{$_ -replace "\-.*", ""}
    $build=$html | select-string -Pattern "splunk-$req_version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique | %{$_ -replace "splunk\-.*?\-", ""} | %{$_ -replace "\-.*", ""}
        
        echo ""
        echo "Displaying WGET Statements for Splunk:
        Version: $version
        Build: $build"
    
        echo ""
        echo "-------- Linux Tarball (TGZ) "
        echo ""
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
        echo ""
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
        echo ""

        echo "-------- RHEL Package Manager (RPM) "
        echo ""
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
        echo ""
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
        echo ""

        echo "-------- Windows Installation (MSI) "
        echo ""
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-x64-release.msi'"
        echo ""
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-x64-release.msi'"
}
echo ""
echo "Thank you, and have a day"
echo ""
