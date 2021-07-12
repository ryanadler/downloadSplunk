# Clear Screen;
clear;
# Grab the Latest Splunk versions and Variables;
$html=curl 'https://www.splunk.com/en_us/download/sem.html';
$nixtgzFilename=$html | Select-String -Pattern "splunk\-.*?Linux\-x86_64\.tgz" |  % { $_.Matches } | % { $_.Value};
$nixrpmFilename=$html | Select-String -Pattern "splunk\-.*?\.rpm" |  % { $_.Matches } | % { $_.Value};
$winFilename=$html | select-string -Pattern "splunk\-.*?\-x64\-release\.msi" | % { $_.Matches } | % { $_.Value};
$latest_version=$nixtgzFilename | %{$_ -replace "splunk-",""} | %{$_ -replace "\-.*",""};
$build=$nixtgzFilename | %{$_ -replace "splunk-.*?\-",""}  | %{$_ -replace "\-.*",""};
# Engage with the User;
echo "";
echo "";
echo "Welcome To The Splunk Download Script. Please Choose From The Following Options:";
echo "";
echo "The Latest Release Of Splunk is: 
Version: $latest_version 
Build: $build";
echo "";
$grabLatest = Read-Host "Would you like WGET statements for the Latest Version? (y/n)";
echo "";
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
        echo "wget -O $nixtgzFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=splunk&filename=$nixtgzFilename&wget=true'"
        echo ""
        echo "Splunk Forwarder:"
        $nixtgzFWD=$nixtgzFilename | %{$_ -replace "splunk","splunkforwarder"}
        echo "wget -O $nixtgzFWD 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=universalforwarder&filename=$nixtgzFW&wget=true'"
        echo ""

        echo "-------- RHEL Package Manager (RPM) "
        echo ""
        echo "Enterprise:"
        echo "wget -O $nixrpmFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=splunk&filename=$nixrpmFilename&wget=true'"
        echo ""
        echo "Splunk Forwarder:"
        $nixrpmFWD=$nixrpmFilename | %{$_ -replace "splunk","splunkforwarder"}
        echo "wget -O $nixrpmFWD 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=universalforwarder&filename=$nixrpmFW&wget=true'"
        echo ""

        echo "-------- Windows Installation (MSI) "
        echo ""
        echo "Enterprise:"
        echo "wget -O $winFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$latest_version&product=splunk&filename=$winFilename&wget=true'"
        echo ""
        echo "Splunk Forwarder:"
        $winFWD=$winFilename | %{$_ -replace "splunk","splunkforwarder"}
        echo "wget -O $winFWD 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$latest_version&product=universalforwarder&filename=$winFWD&wget=true'"
};
#
if ($grabLatest -eq 'n')
{
    $html=curl 'https://www.splunk.com/page/previous_releases' 
    $req_version = Read-Host "Which Version Would You Like? (example: 7.2.10.1 or 8.1.3)"
    $version=$html | select-string -Pattern "splunk-$req_version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique | %{$_ -replace "splunk\-", ""} | %{$_ -replace "\-.*", ""}
    $build=$html | select-string -Pattern "splunk-$req_version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique | %{$_ -replace "splunk\-.*?\-", ""} | %{$_ -replace "\-.*", ""}
    echo ""
    echo "Displaying WGET Statements for Splunk:
    Version: $version
    Build: $build"
    
    echo ""
        echo "-------- Linux Tarball (TGZ) "
        $nixtgzFilename="splunk-$version-$build-Linux-x86_64.tgz"
        echo ""
        echo "Enterprise:"
        echo "wget -O $nixtgzFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=splunk&filename=$nixtgzFilename&wget=true'"
        echo ""
        echo "Splunk Forwarder:"
        $nixtgzFWD=$nixtgzFilename | %{$_ -replace "splunk","splunkforwarder"}
        echo "wget -O $nixtgzFWD 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=universalforwarder&filename=$nixtgzFW&wget=true'"
        echo ""

        echo "-------- RHEL Package Manager (RPM) "
        $nixrpmFilename="splunk-$version-$build-linux-2.6-x86_64.rpm"
        echo ""
        echo "Enterprise:"
        echo "wget -O $nixrpmFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=splunk&filename=$nixrpmFilename&wget=true'"
        echo ""
        echo "Splunk Forwarder:"
        $nixrpmFWD=$nixrpmFilename | %{$_ -replace "splunk","splunkforwarder"}
        echo "wget -O $nixrpmFWD 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=$latest_version&product=universalforwarder&filename=$nixrpmFW&wget=true'"
        echo ""

        echo "-------- Windows Installation (MSI) ";
        $winFilename="splunk-$version-$build-x64-release.msi"
        echo ""
        echo "Enterprise:"
        echo "wget -O $winFilename 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$latest_version&product=splunk&filename=$winFilename&wget=true'"
        echo ""
        echo "Splunk Forwarder:"
        $winFWD=$winFilename | %{$_ -replace "splunk","splunkforwarder"}
        echo "wget -O $winFWD 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=$latest_version&product=universalforwarder&filename=$winFWD&wget=true'"
};
echo "";
echo "Thank you, and have a day";
echo "";