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
sudo a2enmod ssl > /dev/null
sudo systemctl restart apache2 > /dev/null
sudo a2enmod auth_digest > /dev/null
sudo systemctl restart apache2 > /dev/null
sudo a2enmod reqtimeout > /dev/null
sudo systemctl restart apache2 > /dev/null

sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig > /dev/null
sudo cp ins/1804-BionicBeaver/setup/apache2.conf /etc/apache2/apache2.conf > /dev/null
sudo systemctl restart apache2 > /dev/null

sudo openssl req -nodes -newkey rsa:2048 -keyout /etc/apache2/apache.pem -out /etc/apache2/apache.pem -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com" > /dev/null
sudo chmod 600 /etc/apache2/apache.pem > /dev/null

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
