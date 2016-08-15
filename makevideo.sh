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
    if [ ! -f $d/`basename $d`-timelapse-${dat}.mp4 ]; then
      log "processing $d/`basename $d`-timelapse-$dat.gif"
      count=1
      for f in `ls $d/*${dat}*.jpg`; do
        countzero=$(printf "%05d" $count)
        sudo cp $f /tmpfs/image_${countzero}.jpg
        let count="$count+1";
      done
      avconv -r 10 -i /tmpfs/image_%05d.jpg  \
        -r 10 -vcodec libx264 -crf 20 -g 15 \
        $d/`basename $d`-timelapse-$dat.mp4
      sudo rm /tmpfs/*
    fi
  done
done
