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
#---------------------------------------------------------------------------------------------------------#


########################
##  Install xmlrpc-c  ##
########################
echo 'Installing xmlrpc-c'
mkdir -p "$HOME"/$dirxmlrpcc
cd "$HOME"/rtexe/temp/xmlrpc-c
sudo apt-get -yqq install subversion > /dev/null
svn checkout $xmlrpcc_dl xmlrpc-c > /dev/null
cd xmlrpc-c
./configure --disable-cplusplus > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1
cd ../..
#---------------------------------------------------------------------------------------------------------#


##########################
##  Install libtorrent  ##
##########################
echo 'Installing libtorrent'
mkdir -p "$HOME"/$dirlibtorrent
cd "$HOME"/rtexe/temp/libtorrent
curl -sL $libtorrent_dl -o libtorrent.tar.gz > /dev/null
tar -zxvf libtorrent.tar.gz > /dev/null
rm libtorrent.tar.gz
cd libtorrent-0.13.8
./autogen.sh > /dev/null 2>&1
./configure > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1
cd ../..
#---------------------------------------------------------------------------------------------------------#


########################
## Installing Webmin  ##
########################
#echo 'Installing Webmin'
#mkdir -p /home/$user/$dirvar
#cd /home/$user/rtexe/temp/webmin
#sudo apt-get -y update
#sudo cp ins/1804-BionicBeaver/setup/phpinfo.php /var/www/html/phpinfo.php
#sudo cp ins/1804-BionicBeaver/setup/php.ini /var/www/html/php.ini
#echo 'deb http://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list
#wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add
#sudo apt-get -y update
#sudo apt-get -y install webmin
#---------------------------------------------------------------------------------------------------------#


#################
## FINAL TASKS ##
#################
#echo "Setting permissions, Starting services"
#chown -R www-data:www-data /var/www
#chown -R $user:$user $home
#
#su $user -c '/etc/init.d/rtorrent-init restart'
#su $user -c '/etc/init.d/rtorrent-init -i restart'
#sudo service rtorrent-init restart
#---------------------------------------------------------------------------------------------------------#