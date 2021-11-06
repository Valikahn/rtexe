#!/bin/bash

#####################
##  SET VARIABLES  ##
#####################

# Server IP Address - Ipv4 only
# grep 'inet6' instead of 'inet ' for ipv6
ip=$(ip addr | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | grep -v "127." | head -n 1)

# Server Version
# Server version variable
OS=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VERSION=$(awk '/DISTRIB_RELEASE=/' /etc/*-release | sed 's/DISTRIB_RELEASE=//' | sed 's/[.]0/./')

if [ -z "$OS" ]; then
OS=$(awk '{print $1}' /etc/*-release | tr '[:upper:]' '[:lower:]')
fi

if [ -z "$VERSION" ]; then
VERSION=$(awk '{print $3}' /etc/*-release)
fi
	
	
# Version Control
SCRIPTVERSION="v1.0.3-charlie"
REVDATE="06 November 2021"
DEVNAME="Ra"
GITHUB="https://github.com/Valikahn/rutorrent-auto-install"


# List of variables
export logfile="/dev/null"
webpass=''
forceyes=1
passflag=0
passfile='/etc/apache2/.htpasswd'

unixpass=""
os_prereq=0
prereq=0

bb_1804='1)  Ubuntu 18.04 (Bionic Beaver)'
ff_2004='2)  Ubuntu 20.04 (Focal Fossa)'
hh_2104='3)  Ubuntu 21.04 (Hirsute Hippo)'
ii_2110='4)  Ubuntu 21.10 (Impish Indri)'
osnot_listed='5)  Operating System Version Not Listed'

intermess='code/scripts/InteractionMessage.sh'
bb_pack_1804='code/1804-BionicBeaver/ins-pack-1804.sh'
bb_func_1804='code/1804-BionicBeaver/ins-func-1804.sh'

vsftpd_conf='config/vsftpd.conf'
apache2_conf='config/apache2.conf'
rt_rc='config/rtorrent.rc'

rt_url="https://rakshasa.github.io/rtorrent/"
xmlrpc_url="https://svn.code.sf.net/p/xmlrpc-c/code/advanced/"
ru_url="https://github.com/Novik/ruTorrent/"
adl_url="https://github.com/autodl-community/"

homedir=$(cat /etc/passwd | grep "$user": | cut -d: -f6)
home=$(eval echo "~$user")
