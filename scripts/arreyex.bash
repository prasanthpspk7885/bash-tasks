#!/bin/bash
# simple array list and loop for display
SERVERLIST=("apachie" "tomcat" "nginx" "aws")
COUNT=0
for INDEX in ${SERVERLIST[@]}; do
 echo "Processing Server: ${SERVERLIST[COUNT]}"
 COUNT="`expr $COUNT + 1`"
done

