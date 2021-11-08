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


########################
##  Install rTorrent  ##
########################
echo 'Installing rTorrent'
mkdir -p "$HOME"/$dirrTorrent
cd "$HOME"/rtexe/temp/rTorrent
curl -sL $rTorrent_dl -o rtorrent.tar.gz > /dev/null
tar -zxvf rtorrent.tar.gz > /dev/null
rm rtorrent.tar.gz
cd rtorrent-0.9.8
./autogen.sh > /dev/null 2>&1
./configure --with-xmlrpc-c > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1

cd $home

mkdir -p rtorrent/.session
mkdir -p rtorrent/download
mkdir -p rtorrent/watch

cp -f "$HOME"/rtexe/config/rtorrent.rc $HOME/.rtorrent.rc
sed -i "s|<user home>|${home}|g" $home/.rtorrent.rc
sed -i "s/<user name>/$user/g" $home/.rtorrent.rc


#########################
##  Install ruTorrent  ##
#########################
echo 'Installing ruTorrent'
sudo apt-get -yqq install rtorrent > /dev/null
mkdir -p "$HOME"/$dirruTorrent
cd "$HOME"/rtexe/temp/ruTorrent
curl -sL $ruTorrent_dl -o ruTorrent-master.tar.gz > /dev/null
tar -zxvf ruTorrent-master.tar.gz > /dev/null
rm ruTorrent-master.tar.gz

if [ -d /var/www/html/rutorrent ]; then
		rm -r /var/www/html/rutorrent
fi

mv ruTorrent-master rutorrent
cp -r rutorrent /var/www/html/

chown -R www-data.www-data /var/www/html/rutorrent/
chmod -R 775 /var/www/html/rutorrent/

service apache2 restart
systemctl reload apache2

echo 'Configuring ruTorrent'
cd

rm /var/www/html/rutorrent/conf/config.php
cp -f $HOME/rtexe/config/ruTorrent.config /var/www/html/rutorrent/conf/config.php
mkdir -p /var/www/html/rutorrent/conf/users/$user/plugins
cd /var/www/html/rutorrent/conf/users/$user/plugins

echo "<?php" > config.php
echo >> config.php
echo "\$homeDirectory = \"$HOME\";" >> config.php
echo "\$topDirectory = \"$HOME\";" >> config.php
echo "\$scgi_port = 5000;" >> config.php
echo "\$XMLRPCMountPoint = \"/RPC2\";" >> config.php
echo >> config.php
echo "?>" >> config.php
cd ../../..

sudo mv plugins.ini plugins.ini.orig
sudo cp -f $HOME/rtexe/config/ruTorrent.ini /var/www/html/rutorrent/conf/plugins.ini
sudo cp -f $HOME/rtexe/config/rtorrent-init /etc/init.d/rtorrent-init

chmod +x /etc/init.d/rtorrent-init
sed -i "s/<user name>/$user/g" /etc/init.d/rtorrent-init
update-rc.d rtorrent-init defaults
service apache2 restart

sudo service apache2 restart
sudo /etc/init.d/rtorrent-init start

########################
## Installing Webmin  ##
########################
#echo 'Installing Webmin'
#mkdir -p "$HOME"/$dirvar
#cd "$HOME"/rtexe/temp/webmin
#sudo apt-get -y update
#sudo cp ins/1804-BionicBeaver/setup/phpinfo.php /var/www/html/phpinfo.php
#sudo cp ins/1804-BionicBeaver/setup/php.ini /var/www/html/php.ini
#echo 'deb http://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list
#wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add
#sudo apt-get -y update
#sudo apt-get -y install webmin


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
