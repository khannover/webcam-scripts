#!/bin/bash

log=/home/pi/scripts/webcams/makeblog.txt
currentMin=`date +%M`

dataPath=/home/pi/webcam-data
htmlroot=/wwwroot/webcams

function log(){
  echo "`date`: $1" >> $log
}

find $dataPath -name "*.blog" -exec rm "{}" \;
cd $htmlroot
  for d in `find . -mindepth 1 -type d`; do
    for i in `ls -1 $d/*-timelapse-*.mp4`; do
       cam=`echo $i | awk -F"/" '{print $2}'`
       dat=`echo $i | awk -F"/" '{print $3}' | sed 's/.*-\([0-9]*\)\..*/\1/g'`
       title="$cam - ${dat:4:2}.${dat:2:2}.${dat:0:2}"
       if [ "${dat:4:20}" == "01" ]; then
           daySuffix="st"
       elif [ "${dat:4:20}" == "02" ]; then
           daySuffix="nd"
       elif [ "${dat:4:20}" == "03" ]; then
           daySuffix="rd"
       else
           daySuffix="th"
       fi
       dateFormatted=`date --date=$dat "+%d$daySuffix %B 20%y"`
       filename="$cam-$dat.blog"
       echo "title:  $title" >> $dataPath/$filename
       echo "Tags: $cam,20${dat:0:2}" >> $dataPath/$filename
       echo "Date: $dateFormatted" >> $dataPath/$filename
       echo "" >> $dataPath/$filename
       echo "<video width=\"320\" height=\"240\" controls preload=metadata>" >> $dataPath/$filename
       echo "   <source src=\"/webcams/$i\" type=\"video/mp4\">" >> $dataPath/$filename
       echo '     Your browser does not support the video tag.' >> $dataPath/$filename
       echo '</video><br><br>' >> $dataPath/$filename
    done
  done
exit
