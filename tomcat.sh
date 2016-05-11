#!/bin/bash
# Sample wordpress script 1
echo 127.0.0.1 `hostname` >> /etc/hosts
apt-get -y update
#Install Apache
sudo apt-get -y install tomcat7
sudo dpkg --configure -a
