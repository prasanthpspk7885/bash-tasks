#!/bin/bash
#3) Bash script to install nginx and run on port number 80.
sudo yum update
sudo yum install nginx -y
sed -i 's/listen\s*80;/listen 80 default_server;/g' /etc/nginx
sudo systemctl restart nginx
sudo systemctl status nginx
