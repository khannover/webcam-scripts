#!/bin/bash

log=/home/pi/scripts/webcams/log.txt
currentMin=`date +%M`
configs=`ls /home/pi/scripts/webcams/*.cfg`

if [ $# -gt 0 ]; then
   htmlPath=$1
   htmlFile=$2
   
else
   htmlPath=""
fi

function log(){
  echo "`date`: $1" >> $log
}
for c in $configs; do
  while read line; do
    url=`echo $line | awk '{print $1}'`
    activeMins=`echo $line | awk '{print $2}'`
    target=`echo $line | awk '{print $3}'`
    nowActive=""
    for m in `echo $activeMins | sed 's/,/ /g'`; do
      if [ $currentMin -eq $m ]; then
        nowActive=yes
        break
      fi
    done
    if [ "$nowActive" == "yes" ]; then
      filename="`basename $target`-$filename"
      filedate=`date +%y%m%d-%H%M%S`
      wget $url -O  $target/$filename-$filedate.jpg
      log "saving $target/$filename-$filedate.jpg"
    else
      echo "no time slice for `basename $target`"
    fi
  done < $c
done

if [ "$htmlPath" != "" ]; then
  cd $htmlPath
  echo "" > $htmlFile
  for d in `find . -mindepth 1 -type d`; do
    for i in `ls -1 $d/*timelapse*.mp4`; do
      echo "<a href=$i>$i</a><br>" >> $htmlFile
      echo '
  <video width="320" height="240" controls>
    <source src="'$i'" type="video/mp4">
  Your browser does not support the video tag.
  </video><br><br>
  ' >> $htmlFile
    done
  done
fi
exit
