#!/bin/bash

rm -f /opt/data/splunkbase/active_apps.list
for pointer in $( cat /opt/splunk/etc/apps/splunkbase_list/bin/pointers )
do
    echo
    echo "Getting Splunkbase app at https://splunkbase.splunk.com/app/$pointer/"
    echo
    wget -O activeOutput 'https://splunkbase.splunk.com/app/'$pointer -q

    if [ -s activeOutput ]; then
        echo "Logging Contents"
        bapp=$(cat activeOutput | grep "title" | head -1 | grep -oE ">.*<" | sed "s/<//g" | sed "s/>//g" | sed "s/...Splunkbase//g")
	app=$(echo $bapp | sed 's/,/-/g')
	version=$(cat activeOutput | grep "release-notes-version" | head -1 | grep -oE "([[:digit:]]\.[[:digit:]]\.[[:digit:]]|[[:digit:]]\.[[:digit:]])")
	author=$(cat activeOutput | grep author | grep -oE ">\w+.*<"  | sed 's/>//g' | sed 's/<//g')
	compatibility=$(cat activeOutput | grep -e "splunk\/versions" | grep -oE "[[:digit:]]\.[[:digit:]]" | sort | uniq | tr '\n' ' ')
	if [ -z "$compatibility" ]; then
		compatibility="null"
	fi
        lastUpdated=$(cat activeOutput | grep "u.item sb.color:gray" | head -1 | grep -oE ">.*<" | sed "s/<//g" | sed "s/>//g" | sed "s/\,/ /g")
        url="https://splunkbase.splunk.com/app/$pointer/"
        echo "$app,$version,$lastUpdated,$url,$compatibility,$author" >> /opt/data/splunkbase/active_apps.list
        rm -f activeOutput
    else
        app="null"
        version="null"
	author="null"
        lastUpdated="null"
	compatibility="null"
        url="https://splunkbase.splunk.com/app/$pointer/"
        echo "$app,$version,$lastUpdated,$url,$compatibility,$author" >> /opt/data/splunkbase/active_apps.list
        rm -f activeOutput

    fi

done

rm -f /opt/splunk/etc/apps/splunkbase_list/bin/activeOutput
