#!/bin/bash
# demo of the case statement
clear
echo "MAIN MENU"
echo "========="
echo "1) aws"
echo "2) Linux"
echo "3) Devops"
echo ""
echo "Enter Choice: "
read MENUCHOICE
case $MENUCHOICE in
 1)
 echo "Congratulations for Choosing the First Option  aws service are Ec2,s3 iam Loadbalencer,cloudwatch ";;
 2)
 echo "Choice 2 Chosen Linux ---redhat,ubantu ";;
 3) 
 echo "Last Choice Devops git Devops Linux,ansable";;
 *)
 echo "You chose unwisely";;
esac
