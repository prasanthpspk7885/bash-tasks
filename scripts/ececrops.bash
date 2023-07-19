#!/bin/bash
# execution operators example
echo "Enter a number between 1 and 25: "
read VALUE
if [ "$VALUE" -eq "1" ] || [ "$VALUE" -eq "1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25" ] || [ "$VALUE" -eq "25" ]; 
then
 echo "You entered the ODD value of $VALUE"
else
 echo "You entered a value of $VALUE"
fi
