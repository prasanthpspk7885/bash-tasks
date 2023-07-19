#!/bin/bash
# Search and delete .txt files
#set the Directory path
DIRECTORY="/home/ec2-user/bash"
 #Find the delete files with .txt
find "$DIRECTORY" -type f -name "*.txt" -delete
echo "Files with .txt extension have been deleted"
