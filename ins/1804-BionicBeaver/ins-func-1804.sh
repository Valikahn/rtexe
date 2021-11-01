#!/bin/bash
echo
pause 3

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
