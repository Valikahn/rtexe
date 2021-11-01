#!/bin/bash
echo
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

##################################
##  Installing Apache2 and PHP  ##
##################################
echo 'Installing Apache and PHP'
sudo apt-get -yqq install apache2 > /dev/null
sudo apt-get -yqq install php php-cgi libapache2-mod-php > /dev/null
sudo apt-get -yqq install php-mysql php-gd > /dev/null
sudo systemctl restart apache2

fi