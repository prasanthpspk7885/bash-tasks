#!/bin/bash

count=0
num=100
while [ $count -lt 100 ]
do
        echo
        echo $num seconds left to stop this process $1
        echo
        sleep 1

num=`expr $num - 1`
count=`expr $count + 1`
done
echo
echo $1 process is stopped!!!
echo

