#!/bin/bash
sleep 3
OSVER="1804-BionicBeaver"
#$OS
#$VERSION


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
cd "$HOME"/rutorrent-auto-install/temp/xmlrpc-c
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
cd "$HOME"/rutorrent-auto-install/temp/libtorrent
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
cd "$HOME"/rutorrent-auto-install/temp/rTorrent
curl -sL $rTorrent_dl -o rtorrent.tar.gz > /dev/null
tar -zxvf rtorrent.tar.gz > /dev/null
rm rtorrent.tar.gz
cd rtorrent-0.9.8
./autogen.sh > /dev/null 2>&1
./configure --with-xmlrpc-c > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1
cd ../..

if [ ! -d "/home/$user"/.rtorrent-session ]; then
	mkdir "/home/$user"/.rtorrent-session
	chown "$user"."$user" "/home/$user"/.rtorrent-session
else
	chown "$user"."$user" "/home/$user"/.rtorrent-session
fi
	
# Creating downloads folder
###
if [ ! -d "/home/$user"/Downloads ]; then
	mkdir "/home/$user"/Downloads
	chown "$user"."$user" "/home/$user"/Downloads
else
	chown "$user"."$user" "/home/$user"/Downloads
fi
	
# Creating unpack folder
###
if [ ! -d "/home/$user"/Downloads/unpack ]; then
	mkdir "/home/$user"/Downloads/unpack
	chown "$user"."$user" "/home/$user"/Downloads/unpack
else
	chown "$user"."$user" "/home/$user"/Downloads/unpack
fi

sudo cp "$HOME"/$rt_rc $HOME/.rtorrent.rc
chown "$user"."$user" $HOME/.rtorrent.rc
sed -i "s@HOMEDIRHERE@$HOME@g" $HOME/.rtorrent.rc


#########################
##  Install ruTorrent  ##
#########################
echo 'Installing ruTorrent'
cd "$HOME"/rutorrent-auto-install/temp/ruTorrent
curl -sL $ruTorrent_dl -o ruTorrent-master.tar.gz > /dev/null
tar -zxvf ruTorrent-master.tar.gz > /dev/null
rm ruTorrent-master.tar.gz

if [ -d /var/www/html/rutorrent ]; then
		rm -r /var/www/html/rutorrent
fi

#echo 'Creating Apache virtual host'
#if [ ! -f /etc/apache2/sites-available/rutorrent.conf ]; then
#
#cat > /etc/apache2/sites-available/rutorrent.conf << EOF
#<VirtualHost *:80>

#	ServerAlias *

#	DocumentRoot /var/www/html/

#	CustomLog /var/log/apache2/rutorrent.log vhost_combined

#	ErrorLog /var/log/apache2/rutorrent_error.log

#	SSLEngine on
#	SSLCertificateFile /etc/apache2/apache.pem

#	<Directory "/var/www/html/rutorrent">
#		AuthName "GTFO"
#		AuthType Basic
#		Require valid-user
#		AuthUserFile /var/www/html/rutorrent/.htpasswd
#	</Directory>
#</VirtualHost>
#EOF

#a2ensite rutorrent

#fi

##################################################################
####################  SCRIPT FAILS FROM HERE  ####################
###########################  LOG BELOW  ##########################
##################################################################


#service apache2 restart
#systemctl reload apache2
#
#echo 'Configuring Rutorrent'
#mv ruTorrent-master rutorrent
#cp -r rutorrent /var/www/html/
#cd /var/www/html/
#
#cd
#
#mkdir -p /var/www/html/rutorrent/conf/users/$user/plugins
#
#echo "<?php" > /var/www/html/rutorrent/conf/users/$user/config.php
#echo >> /var/www/html/rutorrent/conf/users/$user/config.php
#echo "\$homeDirectory = \"$home\";" >> /var/www/html/rutorrent/conf/users/$user/config.php
#echo "\$topDirectory = \"$home\";" >> /var/www/html/rutorrent/conf/users/$user/config.php
#echo "\$scgi_port = 5000;" >> /var/www/html/rutorrent/conf/users/$user/config.php
#echo "\$XMLRPCMountPoint = \"/RPC2\";" >> /var/www/html/rutorrent/conf/users/$user/config.php
#echo >> /var/www/html/rutorrent/conf/users/$user/config.php
#echo "?>" >> /var/www/html/rutorrent/conf/users/$user/config.php
#
#sudo mv /var/www/html/rutorrent/conf/plugins.ini /var/www/html/rutorrent/conf/plugins.ini.orig
#sudo cp -f rutorrent-auto-install/ins/1804-BionicBeaver/setup/ruTorrent.ini /var/www/html/rutorrent/conf/plugins.ini
#
#sudo cp -f rutorrent-auto-install/ins/1804-BionicBeaver/setup/rtorrent-init /etc/init.d/rtorrent-init
#
#chmod +x /etc/init.d/rtorrent-init
#sed -i "s/USERNAMEHERE/$user/g" /etc/init.d/rtorrent-init
#update-rc.d rtorrent-init defaults
#service apache2 restart
#
#sudo mv /var/www/html/rutorrent/conf/config.php /var/www/html/rutorrent/conf/config.php.orig
#sudo cp rutorrent-auto-install/ins/1804-BionicBeaver/setup/config.php /var/www/html/rutorrent/conf/config.php
#sudo service apache2 restart


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


########################
## Installing Webmin  ##
########################
#echo 'Installing Webmin'
#sudo apt-get -y update
#sudo cp ins/1804-BionicBeaver/setup/phpinfo.php /var/www/html/phpinfo.php
#sudo cp ins/1804-BionicBeaver/setup/php.ini /var/www/html/php.ini
#echo 'deb http://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list
#wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add
#sudo apt-get -y update
#sudo apt-get -y install webmin