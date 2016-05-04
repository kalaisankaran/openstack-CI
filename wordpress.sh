#!/bin/bash

echo 127.0.0.1 `hostname` >> /etc/hosts
apt-get -y update
#Install Apache
apt-get -y install apache2
#Install MySQL
export DEBIAN_FRONTEND=noninteractive 
apt-get -y install mysql-server
#Install PHP
apt-get -y install php5 libapache2-mod-php5
apt-get -y update
apt-get -y install php5-gd libssh2-php php5-mysqlnd-ms
#Restart Server
/etc/init.d/apache2 restart
php -r 'echo "\n\nYour PHP installation is working fine.\n\n\n";'

#MySQL Configuration
sed -i "s/bind/#bind/g" /etc/mysql/my.cnf
cat << EOF | mysql
CREATE DATABASE wordpress;
CREATE USER wordpress@localhost IDENTIFIED BY 'trov';
GRANT ALL PRIVILEGES ON wordpress.* TO "wordpress"@"localhost" IDENTIFIED BY "trov";
FLUSH PRIVILEGES; 
EXIT
EOF
/etc/init.d/mysql restart

#Configure wordpress
cd ~
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cd ~/wordpress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress/g" wp-config.php
sed -i "s/username_here/wordpress/g" wp-config.php
sed -i "s/password_here/trov/g" wp-config.php
sudo rsync -avP ~/wordpress/ /var/www/html/
cd /var/www/html
sudo chown -R www-data:www-data *
mkdir /var/www/html/wp-content/uploads
sudo chown -R :www-data /var/www/html/wp-content/uploads
rm index.html
/etc/init.d/apache2 restart


