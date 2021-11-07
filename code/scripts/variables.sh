#!/bin/bash
export logfile="/dev/null"
homedir=$(cat /etc/passwd | grep "$user": | cut -d: -f6)
HOME=$(eval echo "~$user")

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


#####################
##  SET VARIABLES  ##
#####################


# Version Control
SCRIPTVERSION="v1.0.4-charlie"
REVDATE="06 November 2021"
DEVNAME="Ra"
GITHUB="https://github.com/Valikahn/rutorrent-auto-install"
#---------------#

# Folder Variables
dirxmlrpcc='rutorrent-auto-install/temp/xmlrpc-c'
dirlibtorrent='rutorrent-auto-install/temp/libtorrent'
dirrTorrent='rutorrent-auto-install/temp/rTorrent'
dirruTorrent='rutorrent-auto-install/temp/ruTorrent'
dirplugins='rutorrent-auto-install/temp/plugins'
#----------------#

# Password Variables
webpass=''
forceyes=1
passflag=0
passfile='/etc/apache2/.htpasswd'
unixpass=""
os_prereq=0
prereq=0
#------------------#

# Switch Case Variables
bb_1804='1)  Ubuntu 18.04 (Bionic Beaver)'
ff_2004='2)  Ubuntu 20.04 (Focal Fossa)'
hh_2104='3)  Ubuntu 21.04 (Hirsute Hippo)'
ii_2110='4)  Ubuntu 21.10 (Impish Indri)'
osnot_listed='5)  Operating System Version Not Listed'
func='code/scripts/func.sh'
us_int='code/scripts/us_int.sh'
intermess='code/scripts/intermess.sh'
bb_pack_1804='code/1804-BionicBeaver/ins-pack-1804.sh'
bb_func_1804='code/1804-BionicBeaver/ins-func-1804.sh'
#---------------------#

# Pack Variables
vsftpd_conf='config/vsftpd.conf'
apache2_conf='config/apache2.conf'
rt_rc='rutorrent-auto-install/config/rtorrent.rc'
#--------------#

# Check/Download URL's Variables
rt_url="https://rakshasa.github.io/rtorrent/"
xmlrpc_url="https://svn.code.sf.net/p/xmlrpc-c/code/advanced/"
ru_url="https://github.com/Novik/ruTorrent/"
adl_url="https://github.com/autodl-community/"
xmlrpcc_dl="http://svn.code.sf.net/p/xmlrpc-c/code/stable"
libtorrent_dl="https://github.com/rakshasa/rtorrent-archive/raw/master/libtorrent-0.13.8.tar.gz"
rTorrent_dl="https://github.com/rakshasa/rtorrent-archive/raw/master/rtorrent-0.9.8.tar.gz"
ruTorrent_dl="https://github.com/Novik/ruTorrent/archive/master.tar.gz"
#------------------------------#