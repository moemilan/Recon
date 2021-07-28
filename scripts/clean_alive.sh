#!/bin/bash

#Remove Links that are not part of the targeted domain
for i in $(cat $1 | grep -v -E "${2}$"); do
  sed -i "\#$i#d" $1
done

#Remove alive URLs that that has both HTTP and HTTPS
for i in $(cat $1); do
  LINKS=''
  if [ $i != https* ]; then
	  LINKS=$(cat $1 | cut -d '/' -f3 | grep -E "^${i##http://}" | wc -l)
    if [ $LINKS -gt 1 ]; then
      sed -i "\#$i#d" $1
    fi
  else
    echo "$i starts with https"
  fi
done