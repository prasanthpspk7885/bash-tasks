#!/bin/bash
# installing tomcat server
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
sudo yum install java
tar xvf apache-tomcat-9.0.78.tar.gz
cd  apache-tomcat-9.0.78
ls
chmod 777 bin
cd bin
./startup.sh
cd ..
cd webapps
wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
cd ..
cd bin
./shutdown.sh
./startup.sh
