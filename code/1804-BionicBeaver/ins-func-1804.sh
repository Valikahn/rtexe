#!/bin/bash
sleep 3
#---------------------------------------------------------------------------------------------------------#

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
echo -n '   Installing xmlrpc-c'
mkdir -p "$HOME"/$dirxmlrpcc
cd "$HOME"/rtexe/temp/xmlrpc-c
sudo apt-get -yqq install subversion > /dev/null
svn checkout $xmlrpcc_dl xmlrpc-c > /dev/null
cd xmlrpc-c
echo -n ' .'
./configure --disable-cplusplus > /dev/null 2>&1
echo -n '.'
make > /dev/null 2>&1
echo -n '.'
make install > /dev/null 2>&1
cd ../..
echo "${GREEN}   [ Complete ]${NORMAL}"
#---------------------------------------------------------------------------------------------------------#


##########################
##  Install libtorrent  ##
##########################
echo -n '   Installing libtorrent'
mkdir -p "$HOME"/$dirlibtorrent
cd "$HOME"/rtexe/temp/libtorrent
curl -sL $libtorrent_dl -o libtorrent.tar.gz > /dev/null
tar -zxvf libtorrent.tar.gz > /dev/null
rm libtorrent.tar.gz
cd libtorrent-0.13.8
echo -n ' .'
./autogen.sh > /dev/null 2>&1
echo -n '.'
./configure > /dev/null 2>&1
echo -n '.'
make > /dev/null 2>&1
echo -n '.'
make install > /dev/null 2>&1
cd ../..
echo "${GREEN}   [ Complete ]${NORMAL}"
#---------------------------------------------------------------------------------------------------------#


########################
##  Install rTorrent  ##
########################
echo -n '   Installing rTorrent'
mkdir -p "$HOME"/$dirrTorrent
cd "$HOME"/rtexe/temp/rTorrent
curl -sL $rTorrent_dl -o rtorrent.tar.gz > /dev/null
tar -zxvf rtorrent.tar.gz > /dev/null
rm rtorrent.tar.gz
cd rtorrent-0.9.8
echo -n ' .'
./autogen.sh > /dev/null 2>&1
echo -n '.'
./configure --prefix=/usr --with-xmlrpc-c --enable-ipv6 > /dev/null 2>&1
echo -n '.'
make -j > /dev/null 2>&1
echo -n '.'
make -s install > /dev/null 2>&1
echo -n '.'
ldconfig > /dev/null 2>&1

if [ -d /var/www/html/rutorrent/conf/users ]; then
  cd /var/www/rutorrent/conf/users
  user_list=*
  for user in $user_list; do
    if [ ! "$user" = '*' ]; then
      echo "   Restarting rtorrent for $user"
	  screen -d -m -S $SERVICE $SERVICE
    fi
  done
  echo
fi

if [ ! -h /etc/apache2/mods-enabled/scgi.load ]; then
	ln -s /etc/apache2/mods-available/scgi.load /etc/apache2/mods-enabled/scgi.load
fi
echo "${GREEN}   [ Complete ]${NORMAL}"

echo -n '   Configuring rTorrent'
cd $HOME
mkdir -p rtorrent/.session
chown -R "$user"."$user" "$HOME"/rtorrent/.session
mkdir -p rtorrent/download
chown -R "$user"."$user" "$HOME"/rtorrent/download
mkdir -p rtorrent/watch
chown -R "$user"."$user" "$HOME"/rtorrent/watch
mkdir -p rtorrent/download/unpack
chown -R "$user"."$user" "$HOME"/rtorrent/download/unpack

cp -f $HOME/rtexe/config/rt.rc $HOME/.rtorrent.rc
sed -i "s|<user home>|${HOME}|g" $HOME/.rtorrent.rc
sed -i "s/<user name>/$user/g" $HOME/.rtorrent.rc

echo "${GREEN}   [ Complete ]${NORMAL}"
#---------------------------------------------------------------------------------------------------------#


#########################
##  Install ruTorrent  ##
#########################
echo -n '   Installing ruTorrent'
mkdir -p "$HOME"/$dirruTorrent
cd "$HOME"/rtexe/temp/ruTorrent
curl -sL $ruTorrent_dl -o ruTorrent-master.tar.gz > /dev/null
tar -zxvf ruTorrent-master.tar.gz > /dev/null
rm ruTorrent-master.tar.gz
mv ruTorrent-master rutorrent

if [ -d /var/www/html/rutorrent ]; then
		rm -r /var/www/html/rutorrent
fi
echo "${GREEN}   [ Complete ]${NORMAL}"

echo -n '   Configuring ruTorrent'
cp -r rutorrent /var/www/html/
cd /var/www/html/
rm rutorrent/conf/config.php
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

cd /var/www/html/rutorrent/conf
sudo mv plugins.ini plugins.ini.orig
sudo cp -f $HOME/rtexe/config/ruTorrent.ini /var/www/html/rutorrent/conf/plugins.ini

echo "${GREEN}   [ Complete ]${NORMAL}"
#---------------------------------------------------------------------------------------------------------#


##########################
## Setting Permissions  ##
##########################
echo -n '   Setting permissions'
chown -R www-data:www-data /var/www/html
chown -R $user:$user $HOME
sleep 3
mv -f $passfile $passrufile
echo "${GREEN}   [ Complete ]${NORMAL}"

cd $HOME

echo -n "   Starting $SERVICE"
service apache2 restart
systemctl reload apache2
screen -d -m -S $SERVICE $SERVICE
sleep 3
echo "${GREEN}   [ Complete ]${NORMAL}"
#---------------------------------------------------------------------------------------------------------#


########################
## Installing Webmin  ##
########################
echo -n '   Installing Webmin'
mkdir -p /home/$user/$dirwebm
cd "$HOME"/rtexe/temp/webmin
sudo apt-get -yqq update > /dev/null 2>&1
curl -sL $webmin_dl -o webmin.tar > /dev/null 2>&1
tar -zxvf webmin.tar > /dev/null 2>&1
rm webmin.tar
cd webmin-1.981

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp -f $HOME/rtexe/config/src.list /etc/apt/sources.list

wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add > /dev/null 2>&1
sudo apt-get -yqq update > /dev/null 2>&1
sudo apt-get -yqq install webmin > /dev/null 2>&1
cd $HOME
echo "${GREEN}   [ Complete ]${NORMAL}"
#---------------------------------------------------------------------------------------------------------#


###########################
##  Startups / Cronjobs  ##
###########################
echo -n '   Setting rTorrent Cronjob'
echo "${GREEN}   [ Complete ]${NORMAL}"
# rtorrent Cronjob
if [ -z "$(crontab -u $user -l | grep "$cronjob1")" ]; then
    (crontab -u $user -l; echo "$cronjob1" ) | crontab -u $user - >> $logfile 2>&1
fi
sleep 3

#echo -n '   Setting irssi Cronjob'
# irssi Cronjob
#if [ -z  "$(crontab -u $user -l | grep "\*/10 \* \* \* \* /usr/local/bin/rtcheck irssi rtorrent")" ]; then
#    (crontab -u $user -l; echo "$cronline2" ) | crontab -u $user - >> $logfile 2>&1
#fi
#sleep 5
#echo "${GREEN}   [ Complete ]${NORMAL}"
#---------------------------------------------------------------------------------------------------------#


##############
##  Return  ##
##############
cd $HOME/rtexe
#---------------------------------------------------------------------------------------------------------#