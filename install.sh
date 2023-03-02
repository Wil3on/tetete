#!/bin/bash

apt update
apt install apache2 mariadb-server -y
systemctl start apache2
systemctl enable mariadb

mysql -u root -p -e "CREATE DATABASE gcpstory; CREATE USER 'gcpstory'@'localhost' IDENTIFIED BY 'gcpstory22'; GRANT ALL PRIVILEGES ON gcpstory.* TO 'gcpstory'@'localhost'; FLUSH PRIVILEGES;"

apt install php libapache2-mod-php php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc -y
apt install php-apcu -y
php -m | grep -i ioncube
cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar -zxvf ioncube_loaders_lin_x86*
cd ioncube/
php -i | grep extension_dir
extension_dir => /usr/lib/php/20190902 => /usr/lib/php/20190902
cp /tmp/ioncube/ioncube_loader_lin_7.4.so /usr/lib/php/20190902
echo "zend_extension = /usr/lib/php/20190902/ioncube_loader_lin_7.4.so" >> /etc/php/7.4/apache2/php.ini
systemctl restart apache2

cd /var/www/html
rm -rf index.html
wget http://download1644.mediafire.com/gfnpbw5hf0wg/q6ixl638pt6ct2s/webroot.zip
unzip webroot.zip
rm -rf webroot.zip
cd .. 
chmod -R 777 html

echo "Completed"
