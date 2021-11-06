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
sudo apt-get -yqq update > /dev/null
sudo apt-get -yqq upgrade > /dev/null
sudo dpkg --configure -a > /dev/null
sudo apt-get -yqq dist-upgrade > /dev/null

if [ $(dpkg-query -W -f='${Status}' ca-certificates 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
echo 'Installing ca-certificates'
sudo apt-get -yqq install ca-certificates 2>&1 >> /dev/null
fi


###########################
##  Installing Aptitude  ##
###########################
echo 'Installing Aptitude'
sudo apt-get -qqy install aptitude > /dev/null


##################################
##  Installing Apache2 and PHP  ##
##################################
echo 'Installing Apache and PHP'
sudo apt-get -yqq install apache2 > /dev/null
sudo apt-get -yqq install php php-cgi libapache2-mod-php > /dev/null
sudo apt-get -yqq install php-mysql php-gd > /dev/null
sudo systemctl restart apache2
chown -R www-data.www-data /var/www/html/
chmod -R 777 /var/www/html/


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
echo 'Installing Dependencies List 1'
sudo apt-get -yqqf install openssl git apache2-utils build-essential libsigc++-2.0-dev libcurl4-openssl-dev automake ffmpeg cmake mediainfo wget git > /dev/null 2>&1
echo 'Installing Dependencies List 2'
sudo apt-get -yqqf install libcppunit-dev libncurses5-dev curl tmux unzip libssl-dev autoconf ca-certificates mediainfo-gui libfcgi-perl > /dev/null 2>&1
echo 'Installing Dependencies List 3'
sudo apt-get -yqqf install unrar libtool libwandio-dev python-libtorrent zlib1g zlib1g-dev > /dev/null 2>&1
echo

############################################
## Including user to SUDO group of users  ##
############################################
#if groups $user | grep -q -E ' sudo(\s|$)'; then
#  echo "$user already has sudo privileges"
#  echo "WARNING:  With great power comes great responsibility"
#else
#  adduser $user sudo
#  echo
#  echo "$user added to the sudo group of users"
#  echo "WARNING:  With great power comes great responsibility"
#fi
#sleep 5
#echo


##############################################
##  Required Pacakge Installation Complete  ##
##############################################
echo "Required package installation is now complete...  Moving on to Functional Programs"
echo