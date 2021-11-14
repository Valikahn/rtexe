#!/bin/bash

#---------------------------------------------------------------------------------------------------------#

# Various Variables
HOME=$(eval echo "~$user")
export logfile="/dev/null"
cn=$(date +%b)

# Server IP Address - Ipv4 only
# grep 'inet6' instead of 'inet ' for ipv6
ip=$(ip addr | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | grep -v "127." | head -n 1)

# Server Version
# Server version variable
OS=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VERSION=$(awk '/DISTRIB_RELEASE=/' /etc/*-release | sed 's/DISTRIB_RELEASE=//' | sed 's/[.]0/./')
#---------------------------------------------------------------------------------------------------------#

# Version Control
SCRIPTVERSION="v1.14.13"
REVDATE="14 November 2021"
GITHUB="https://github.com/Valikahn/rtexe"
#---------------------------------------------------------------------------------------------------------#

# Egyptian Gods
# https://www.worldhistory.org/article/885/egyptian-gods---the-complete-list/
Jan='Amun'
Feb='Fetket'
Mar='Mekhit'
Apr='Anubis'
May='Mehen'
Jun='Jupiter-Amun'
Jul='Isis'
Aug='Anhur'
Sep='Seth'
Oct='Osiris'
Nov='Nephthys'
Dec='Denwen'
#---------------------------------------------------------------------------------------------------------#

# Color Variables
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
LBLUE=$(tput setaf 6)
RED=$(tput setaf 1)
PURPLE=$(tput setaf 5)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
#---------------------------------------------------------------------------------------------------------#

# Folder Variables
dirxmlrpcc='rtexe/temp/xmlrpc-c'
dirlibtorrent='rtexe/temp/libtorrent'
dirrTorrent='rtexe/temp/rTorrent'
dirruTorrent='rtexe/temp/ruTorrent'
dirwebm='rtexe/temp/webmin'
#---------------------------------------------------------------------------------------------------------#

# Password Variables
webpass=''
forceyes=1
passflag=0
passfile='/var/www/html/.htpasswd'
passrufile='/var/www/html/rutorrent/.htpasswd'
unixpass=""
os_prereq=0
prereq=0
#---------------------------------------------------------------------------------------------------------#

# Switch Case Variables
bb_1804='1)  Ubuntu 18.04 (Bionic Beaver)'
ff_2004='2)  Ubuntu 20.04 (Focal Fossa)'
hh_2104='3)  Ubuntu 21.04 (Hirsute Hippo)'
ii_2110='4)  Ubuntu 21.10 (Impish Indri)'
osnot_listed='5)  Operating System Version Not Listed'
func='code/scripts/func.sh'
us_int='code/scripts/us_int.sh'
bb_pack_1804='code/1804-BionicBeaver/ins-pack-1804.sh'
bb_func_1804='code/1804-BionicBeaver/ins-func-1804.sh'
bb_comp_1804='code/1804-BionicBeaver/ins-comp-1804.sh'

#ff_pack_2004='code/2004-FocalFossa/ins-pack-2004.sh'
#ff_func_2004='code/2004-FocalFossa/ins-func-2004.sh'
#ff_comp_2004='code/2004-FocalFossa/ins-comp-2004.sh'
#hh_pack_2104='code/2104-HirsuteHippo/ins-pack-2104.sh'
#hh_func_2104='code/2104-HirsuteHippo/ins-func-2104.sh'
#hh_comp_2104='code/2104-HirsuteHippo/ins-comp-2104.sh'
#ii_pack_2110='code/2110-ImpishIndri/ins-pack-2110.sh'
#ii_func_2110='code/2110-ImpishIndri/ins-func-2110.sh'
#ii_comp_2110='code/2110-ImpishIndri/ins-comp-2110.sh'
#---------------------------------------------------------------------------------------------------------#

# Message Variables
intermess='code/notices/intermess.sh'
discl='code/notices/disclaimer.sh'
#---------------------------------------------------------------------------------------------------------#

# Pack Variables
sshport=''
sshd='sshd_config'
vsftpd_conf='config/vsftpd.conf'
apache2_conf='config/apache2.conf'
rt_rc='rtexe/config/rtorrent.rc'
#---------------------------------------------------------------------------------------------------------#

# Function Variables
SERVICE='rtorrent'
FILE="$HOME/rtorrent/.session/rtorrent.lock"
#---------------------------------------------------------------------------------------------------------#

# Comp Variables
ixhtml='index.html'
phpinfo='phpinfo.php'
outcred='$HOME/rtorrent/OutputUserDetails.txt'
#---------------------------------------------------------------------------------------------------------#

# Check/Download URL's Variables
rt_url="https://rakshasa.github.io/rtorrent/"
xmlrpc_url="https://svn.code.sf.net/p/xmlrpc-c/code/advanced/"
ru_url="https://github.com/Novik/ruTorrent/"
lib_url="https://rakshasa.github.io/rtorrent/"
adl_url="https://github.com/autodl-community/"
wbmin_url="https://www.webmin.com/"
xmlrpcc_dl="http://svn.code.sf.net/p/xmlrpc-c/code/stable"
libtorrent_dl="https://github.com/rakshasa/rtorrent-archive/raw/master/libtorrent-0.13.8.tar.gz"
rTorrent_dl="https://github.com/rakshasa/rtorrent-archive/raw/master/rtorrent-0.9.8.tar.gz"
ruTorrent_dl="https://github.com/Novik/ruTorrent/archive/master.tar.gz"
webmin_dl="https://prdownloads.sourceforge.net/webadmin/webmin-1.981.tar.gz"
#---------------------------------------------------------------------------------------------------------#
