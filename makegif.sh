#!/bin/bash

folders=/wwwroot/webcams/

log=/home/pi/scripts/webcams/make.log
function log(){
  echo "`date`: $1" >> $log
}


for d in `find $folders -mindepth 1 -type d`; do
  dates=`ls -1 $d | awk -F"-" '{print $3}'  | sort -u`
  log "dates found: $dates"
  for dat in $dates; do
    if [ ! -f $d/animation-${dat}.gif ]; then
      log "processing $d/animation-$dat.gif"
      lastfile=""
      for f in `ls $d/*${dat}*.jpg`; do
        if [ "$lastfile" == "" ]; then
	  lastfile=$f
          continue
        fi
        convert -delay 10 -loop 0 $lastfile $f  $d/animation-${dat}.gif 
        cp $d/animation-${dat}.gif /tmp/animation-${dat}.gif
        lastfile=/tmp/animation-${dat}.gif
      done
      rm $lastfile
    fi
  done
done
