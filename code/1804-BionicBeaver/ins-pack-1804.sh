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


####################################
##  Updating Packages and Builds  ##
####################################
echo 'Updating Packages and Builds'
sudo apt-get -yqq update > /dev/null
sudo apt-get -yqq upgrade > /dev/null
sudo dpkg --configure -a > /dev/null
sudo apt-get -yqq dist-upgrade > /dev/null


###########################
##  Installing Aptitude  ##
###########################
echo 'Installing Aptitude'
sudo apt-get -qqy install aptitude > /dev/null


##################################
##  Installing Apache2 and PHP  ##
##################################
echo 'Installing Apache and PHP'
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

# read -n 1 -r -s -p $'Press enter to continue...\n'


########################
##  SSL Certificates  ##
########################
echo 'Installing SSL Certificate'
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


#########################
##  Installing vsftpd  ##
#########################
echo 'Installing vsftpd'
sudo apt-get -yqq install vsftpd > /dev/null
sudo systemctl start -qq vsftpd
sudo systemctl enable -qq vsftpd
sudo mv /etc/vsftpd.conf /etc/vsftpd.conf.orig
sudo cp $vsftpd_conf /etc/vsftpd.conf
sudo systemctl restart -qq vsftpd


###############################
##  Installing Dependencies  ##
###############################
echo 'Installing Dependencies'
sudo apt-get -yqqf install build-essential libsigc++-2.0-dev libcurl4-openssl-dev automake cmake wget > /dev/null 2>&1
sudo apt-get -yqqf install libcppunit-dev libncurses5-dev libssl-dev autoconf mediainfo mediainfo-gui libfcgi-perl > /dev/null 2>&1
sudo apt-get -yqqf install libtool libwandio-dev python-libtorrent zlib1g zlib1g-dev > /dev/null 2>&1
sudo apt-get -yqqf install rar unrar zip unzip curl mc nano php php-curl php-cli tmux sox ffmpeg > /dev/null 2>&1


##############################################
##  Required Pacakge Installation Complete  ##
##############################################
echo
echo "Required package installation is now complete...  Moving on to Functional Programs"
echo
