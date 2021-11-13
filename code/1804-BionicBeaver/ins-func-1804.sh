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
##  Install rTorrent  ##
########################
echo 'Installing rTorrent'
mkdir -p "$HOME"/$dirrTorrent
cd "$HOME"/rtexe/temp/rTorrent
curl -sL $rTorrent_dl -o rtorrent.tar.gz > /dev/null
tar -zxvf rtorrent.tar.gz > /dev/null
rm rtorrent.tar.gz
cd rtorrent-0.9.8
echo 'autogen'
./autogen.sh > /dev/null 2>&1
echo 'configure'
./configure --prefix=/usr --with-xmlrpc-c --enable-ipv6 > /dev/null 2>&1
echo 'make -j'
make -j > /dev/null 2>&1
echo 'make -s'
make -s install > /dev/null 2>&1
echo 'ldconfig'
ldconfig > /dev/null 2>&1

cd $HOME

echo 'Restart soon'
if [ -d /var/www/html/rutorrent/conf/users ]; then
  cd /var/www/rutorrent/conf/users
  user_list=*
  for user in $user_list; do
    if [ ! "$user" = '*' ]; then
      echo "Restarting rtorrent for $user"
	  screen -d -m -S $SERVICE $SERVICE
    fi
  done
  echo
fi


########################
## Installing Webmin  ##
########################
#echo 'Installing Webmin'
#mkdir -p /home/$user/$dirwebm
#cd "$HOME"/rtexe/temp/webmin
#sudo apt-get -y update
#echo 'deb http://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list
#wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add
#sudo apt-get -y update
#sudo apt-get -y install webmin
#---------------------------------------------------------------------------------------------------------#