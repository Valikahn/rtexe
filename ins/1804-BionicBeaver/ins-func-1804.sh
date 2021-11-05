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
##  SSL Certificates  ##
########################
echo 'Installing SSL Certificate'




########################
##  Install rTorrent  ##
########################
echo 'Installing rTorrent'




#########################
##  Install ruTorrent  ##
#########################
echo 'Installing ruTorrent'
