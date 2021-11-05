#!/bin/bash
sleep 3

################################
##  Checking if user is root  ##
################################
if [ "$(id -u)" != "0" ]; then
	echo
	echo "This script must be run as root." 1>&2
	echo
	exit 1
fi


########################
##  SSL Certificates  ##
########################
echo 'Installing SSL Certificate'

#wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz > /dev/null
#wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz.md5 > /dev/null
#md5sum openssl-1.0.1g.tar.gz > /dev/null
#cat openssl-1.0.1g.tar.gz.md5 > /dev/null

#tar -xvzf openssl-1.0.1g.tar.gz > /dev/null
#cd openssl-1.0.1g > /dev/null

#./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl > /dev/null
#make > /dev/null
#sudo make install > /dev/null
#make install > /dev/null

sudo a2enmod ssl > /dev/null
sudo systemctl restart apache2 > /dev/null
sudo a2enmod auth_digest > /dev/null
sudo systemctl restart apache2 > /dev/null
sudo a2enmod reqtimeout > /dev/null
sudo systemctl restart apache2 > /dev/null

sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig
sudo cp ins/setup/apache2.conf /etc/apache2/apache2.conf
sudo systemctl restart apache2 > /dev/null

sudo openssl req -nodes -newkey rsa:2048 -keyout /etc/apache2/apache.pem -out /etc/apache2/apache.pem -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
sudo chmod 600 /etc/apache2/apache.pem

sudo a2ensite default-ssl > /dev/null
sudo systemctl reload apache2 > /dev/null


########################
##  Install rTorrent  ##
########################
echo 'Installing rTorrent'




#########################
##  Install ruTorrent  ##
#########################
echo 'Installing ruTorrent'




########################
## Installing Webmin  ##
########################
echo 'Installing Webmin'
