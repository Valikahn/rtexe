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
sudo apt-get -yqqf install rtorrent libtorrent19 libxmlrpc-core-c3 > /dev/null 2>&1
curl -sL $rTorrent_dl -o rtorrent.tar.gz > /dev/null
tar -zxvf rtorrent.tar.gz > /dev/null
rm rtorrent.tar.gz
cd rtorrent-0.9.8
./autogen.sh > /dev/null 2>&1
./configure --with-xmlrpc-c > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1
ldconfig > /dev/null 2>&1

cd $HOME

sudo mkdir -p /var/www/source
sudo mkdir -p /var/www/source/files
sudo mkdir -p /var/www/source/watch
sudo mkdir -p /var/www/source/.session

sudo chown -R www-data:www-data /var/www/source
sudo chmod 775 -R /var/www/source

sudo chown $user:$user -R /var/www/source
sudo chown $user:$user -R /var/www/source/files
sudo chown $user:$user -R /var/www/source/watch
sudo chown $user:$user -R /var/www/source/.session

sudo cp -f $HOME/rtexe/config/rtorrent.rc $HOME/.rtorrent.rc
sudo chown $user:$user "$HOME"/.rtorrent.rc


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