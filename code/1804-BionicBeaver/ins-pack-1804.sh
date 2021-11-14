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


####################################
##  Updating Packages and Builds  ##
####################################
echo -n 'Updating Packages and Builds'
sudo apt-get -yqq update > /dev/null
sudo apt-get -yqq upgrade > /dev/null
sudo dpkg --configure -a > /dev/null
sudo apt-get -yqq dist-upgrade > /dev/null
echo "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
#---------------------------------------------------------------------------------------------------------#


##################################
##  Installing Apache2 and PHP  ##
##################################
echo -n 'Installing Apache and PHP'
sudo apt-get -yqq install apache2 apache2-utils > /dev/null
sudo apt-get -yqq install php php-cgi libapache2-mod-php > /dev/null
sudo apt-get -yqq install php-mysql php-gd > /dev/null
sudo systemctl restart apache2
chown -R www-data.www-data /var/www/html/
chmod -R 777 /var/www/html/

if [ -f $passfile ]; then
    htpasswd -b $passfile $user $webpass >> $logfile 2>&1
  else
    htpasswd -c -b $passfile $user $webpass >> $logfile 2>&1
fi

chown www-data:www-data $passfile
chmod 640 $passfile
echo "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
#---------------------------------------------------------------------------------------------------------#


########################
##  SSL Certificates  ##
########################
echo -n 'Installing SSL Certificate'
sudo apt-get -yqqf install openssl ca-certificates > /dev/null 2>&1
sudo a2enmod ssl > /dev/null
sudo systemctl restart apache2 > /dev/null
sudo a2enmod auth_digest > /dev/null
sudo systemctl restart apache2 > /dev/null
sudo a2enmod reqtimeout > /dev/null
sudo systemctl restart apache2 > /dev/null

sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig > /dev/null 2>&1
sudo cp $apache2_conf /etc/apache2/apache2.conf > /dev/null 2>&1
sudo systemctl restart apache2 > /dev/null 2>&1

sudo openssl req -nodes -newkey rsa:2048 -keyout /etc/apache2/apache.pem -out /etc/apache2/apache.pem -subj "/C=VK/ST=Amun/L=Anubis/O=Nephthys/OU=Khnum Nut/CN=Seth.tech" > /dev/null 2>&1
sudo chmod 600 /etc/apache2/apache.pem > /dev/null 2>&1

sudo a2ensite default-ssl > /dev/null
sudo systemctl reload apache2 > /dev/null
echo "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
#---------------------------------------------------------------------------------------------------------#


#########################
##  Installing vsftpd  ##
#########################
echo -n 'Installing vsftpd'
vsftpd_port=$(random 41005 48995)
sudo apt-get -yqq install vsftpd > /dev/null
sudo systemctl start -qq vsftpd
sudo systemctl enable -qq vsftpd
sudo mv /etc/vsftpd.conf /etc/vsftpd.conf.orig
sudo cp $vsftpd_conf /etc/vsftpd.conf
grep ^listen_port /etc/vsftpd.conf > /dev/null || echo "listen_port=$vsftpd_port" >> /etc/vsftpd.conf
sudo systemctl restart -qq vsftpd
vsftpd_port=$(grep 'listen_port=' /etc/vsftpd.conf | sed 's/[^0-9]*//g')
echo -n "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
echo "   FTP port set to $vsftpd_port"
#---------------------------------------------------------------------------------------------------------#


###############################
##  Installing Dependencies  ##
###############################
echo -n 'Installing Dependencies'
sudo apt-get -yqqf install aptitude build-essential libsigc++-2.0-dev libcurl4-openssl-dev automake > /dev/null 2>&1
echo -n ' .'
sudo apt-get -yqqf install cmake wget libcppunit-dev libncurses5-dev curl > /dev/null 2>&1
echo -n '.'
sudo apt-get -yqqf install libssl-dev autoconf mediainfo mediainfo-gui libfcgi-perl > /dev/null 2>&1
echo -n '.'
sudo apt-get -yqqf install libtool libwandio-dev python-libtorrent zlib1g zlib1g-dev > /dev/null 2>&1
echo -n '.'
sudo apt-get -yqqf install nano php php-curl php-cli tmux > /dev/null 2>&1
echo -n '.'
sudo apt-get -yqqf install rar unrar zip unzip mc sox ffmpeg sed libapache2-mod-scgi > /dev/null 2>&1
echo "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
#---------------------------------------------------------------------------------------------------------#


#######################################
##  Return to User Interation Shell  ##
#######################################
cd $HOME/rtexe
#---------------------------------------------------------------------------------------------------------#