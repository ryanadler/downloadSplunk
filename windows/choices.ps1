clear;
echo "";
echo "Welcome to the Splunk download script. Please choose from the following options";
echo "";
$splEnt = Read-Host "Would you like to Download Splunk Enterprise? (y/n)";
 
 
if ($splEnt -eq 'y')
    {
    $latest=wget 'https://www.splunk.com/en_us/download/splunk-enterprise.html' | select-string -Pattern "splunk-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value};
    echo "";
    echo "The latest RPM of Splunk Enterprise is: $latest"
    echo "";
    $grabLatest = Read-Host "Would you like to pull the latest version? (y/n)";
     
    if ($grabLatest -eq 'y')
        {
        echo "";
        echo "Downloading the latest RPM";
        $build=$latest | select-string "\-(\w+)\-" | % { $_.Matches } | % { $_.Value } | select-string "\w+" | % { $_.Matches } | % { $_.Value } | Select-Object -unique ;
        $version=$latest | select-string "(\d\.\d\.\d|\d\.\d\.\d\.\d)" | % { $_.Matches } | % { $_.Value };
        $wget= "https://www.splunk.com/page/download_track?file=$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=$version&product=splunk&typed=release" ; wget -O $latest "$wget"
        };
 
    if ($grabLatest -ne 'y')
        {
        echo "";
        $version = Read-Host "Which previous version would you like to download?";
        $file=wget 'https://www.splunk.com/page/previous_releases' | select-string -Pattern "splunk-$version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique ;
        echo "" ;
        echo "Pulling $file" ;
        $build=$file | select-string "\-(\w+)\-" | % { $_.Matches } | % { $_.Value } | select-string "\w+" | % { $_.Matches } | % { $_.Value } | Select-Object -unique ;
        $wget= "https://www.splunk.com/page/download_track?file=$version/linux/splunk-$version-$build-linux-2.6-x86_64.rpm&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=$version&product=splunk&typed=release" ;
        wget -O $file "$wget"
        };
    };
 
if ($splEnt -ne 'y')
    {
    echo "";
    $splFwd = Read-Host "Would you like to Download the Splunk Forwarder? (y/n)";
 
    if ($splFwd -eq 'y')
        {
        echo "";
        $latest=wget 'https://www.splunk.com/en_us/download/universal-forwarder.html' | select-string -Pattern "splunkforwarder-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value};
        echo "";
        echo "The latest RPM of the Splunk Forwarder is: $latest";
        echo "";
        $grabLatest = Read-Host "Would you like to pull the latest version? (y/n)";
         
        if ($grabLatest -eq 'y')
            {
            echo "";
            echo "Downloading the latest RPM";
            $build=$latest | select-string "\-(\w+)\-" | % { $_.Matches } | % { $_.Value } | select-string "\w+" | % { $_.Matches } | % { $_.Value } | Select-Object -unique ;
            $version=$latest | select-string "(\d\.\d\.\d|\d\.\d\.\d\.\d)" | % { $_.Matches } | % { $_.Value };
            $wget= "https://www.splunk.com/page/download_track?file=$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=$version&product=universalforwarder&typed=release" ; wget -O $latest "$wget"
            } ;
        if ($grabLatest -ne "y")
            {
                $version = Read-Host "Which previous version would you like to download?";
                $file=wget 'https://www.splunk.com/en_us/download/previous-releases/universalforwarder.html' | select-string -Pattern "splunkforwarder-$version-.*?(x64|x86_64).*?\.(rpm)" | % { $_.Matches } | % { $_.Value} | Select-Object -unique ;
                echo "" ;
                echo "Pulling $file" ;
                $build=$file | select-string "\-(\w+)\-" | % { $_.Matches } | % { $_.Value } | select-string "\w+" | % { $_.Matches } | % { $_.Value } | Select-Object -unique ;
                $wget= "https://www.splunk.com/page/download_track?file=$version/linux/splunkforwarder-$version-$build-linux-2.6-x86_64.rpm&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=$version&product=universalforwarder&typed=release" ;
                wget -O $file "$wget"
            };
        };
    };
 
echo "";
echo "Complete"
