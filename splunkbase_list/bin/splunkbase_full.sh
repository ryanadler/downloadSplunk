#!/bin/bash

rm -f /opt/data/splunkbase/full_apps.list
start=1
for pointer in {1..6500}
do
    echo
    echo "Getting Splunkbase app at https://splunkbase.splunk.com/app/$pointer/"
    echo
    wget -O fullOutput 'https://splunkbase.splunk.com/app/'$pointer -q

    if [ -s fullOutput ]; then
        echo "Logging Contents"
        bapp=$(cat fullOutput | grep "title" | head -1 | grep -oE ">.*<" | sed "s/<//g" | sed "s/>//g" | sed "s/...Splunkbase//g")
	app=$(echo $bapp | sed 's/,/-/g')
	version=$(cat fullOutput | grep "release-notes-version" | head -1 | grep -oE "([[:digit:]]\.[[:digit:]]\.[[:digit:]]|[[:digit:]]\.[[:digit:]])")
	author=$(cat fullOutput | grep author | grep -oE ">\w+.*<"  | sed 's/>//g' | sed 's/<//g')
	compatibility=$(cat fullOutput | grep -e "splunk\/versions" | grep -oE "[[:digit:]]\.[[:digit:]]" | sort | uniq | tr '\n' ' ')
	if [ -z "$compatibility" ]; then
		compatibility="null"
	fi
        lastUpdated=$(cat fullOutput | grep "u.item sb.color:gray" | head -1 | grep -oE ">.*<" | sed "s/<//g" | sed "s/>//g" | sed "s/\,/ /g")
        url="https://splunkbase.splunk.com/app/$pointer/"
        echo "$app,$version,$lastUpdated,$url,$compatibility,$author" >> /opt/data/splunkbase/full_apps.list
        rm -f fullOutput
    else
        app="null"
        version="null"
	author="null"
        lastUpdated="null"
	compatibility="null"
        url="https://splunkbase.splunk.com/app/$pointer/"
        echo "$app,$version,$lastUpdated,$url,$compatibility,$author" >> /opt/data/splunkbase/full_apps.list
        rm -f fullOutput

    fi

start=$(($start+1))

    if [[ $pointer -ge 6500 ]];
    then break
    fi

done

rm -f /opt/splunk/etc/apps/splunkbase_list/bin/fullOutput
