# Clear Screen
clear
# Grab the Latest Splunk versions and Variables
wget -O splunkDownload.html 'https://www.splunk.com/en_us/download/splunk-enterprise.html' -q
base=$(grep -oE "splunk\-\d.*?\.rpm" splunkDownload.html| head -1)
version=$(echo $base | grep -oe "\(\d\.\d\.\d\|\d\.\d\.\d\.\d\)")
build=$(echo $base | grep -oe "\w\{7,\}")
rm splunkDownload.html
# Engage with the User
echo
echo
echo "Welcome To The Splunk Download Script."
echo
echo "The Latest Release Of Splunk is: 
Version: $version 
Build: $build"
echo
echo "Would you like WGET statements for the latest version? (y/n)"
read grabLatest
if [ -z "$grabLatest" ]; then
grabLatest="y"
fi

if [ $grabLatest = "y" ]; then
        echo
        echo "Displaying WGET Statements for Splunk:
        Version: $version
        Build: $build"
    
        echo
        echo "-------- Linux Tarball (TGZ) "
        echo
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
        echo
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
        echo

        echo "-------- RHEL Package Manager (RPM) "
        echo
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
        echo
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
        echo

        echo "-------- Windows Installation (MSI) "
        echo
        echo "Enterprise:"
        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-x64-release.msi'"
        echo
        echo "Splunk Forwarder:"
        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-x64-release.msi'"
fi
#if ($grabLatest -eq 'n')
#{
#    $html=curl 'https://www.splunk.com/page/previous_releases' 
#    $req_version = Read-Host "Which Version Would You Like? (example: 7.2.10.1 or 8.1.6)"
#    $version=$html | select-string -Pattern "splunk-$req_version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique | %{$_ -replace "splunk\-", ""} | %{$_ -replace "\-.*", ""}
#    $build=$html | select-string -Pattern "splunk-$req_version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique | %{$_ -replace "splunk\-.*?\-", ""} | %{$_ -replace "\-.*", ""}
#        
#        echo
#        echo "Displaying WGET Statements for Splunk:
#        Version: $version
#        Build: $build"
#    
#        echo
#        echo "-------- Linux Tarball (TGZ) "
#        echo
#        echo "Enterprise:"
#        echo "wget -O splunk-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-Linux-x86_64.tgz'"
#        echo
#        echo "Splunk Forwarder:"
#        echo "wget -O splunkforwarder-$version-$build-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-Linux-x86_64.tgz'"
#        echo
#
#        echo "-------- RHEL Package Manager (RPM) "
#        echo
#        echo "Enterprise:"
#        echo "wget -O splunk-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/splunk/releases/$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm'"
#        echo
#        echo "Splunk Forwarder:"
#        echo "wget -O splunkforwarder-$version-$build-linux-2.6-x86_64.rpm 'https://download.splunk.com/products/universalforwarder/releases/$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm'"
#        echo
#
#        echo "-------- Windows Installation (MSI) "
#        echo
#        echo "Enterprise:"
#        echo "wget -O splunk-$version-$build-x64-release.msi 'https://download.splunk.com/products/splunk/releases/$version/windows/splunk-$version-$build-x64-release.msi'"
#        echo
#        echo "Splunk Forwarder:"
#        echo "wget -O splunkforwarder-$version-$build-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/$version/windows/splunkforwarder-$version-$build-x64-release.msi'"
#}
#echo
#echo "Thank you, and have a day"
#echo
