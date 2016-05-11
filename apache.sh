#!/bin/bash
# Sample wordpress script 1
echo 127.0.0.1 `hostname` >> /etc/hosts

apt-get -y update
#Install Apache
apt-get -y install apache2
