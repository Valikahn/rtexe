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
##  Housekeeping of var/www/html  ##
####################################
echo -n 'Housekeeping'
sleep 3

cd /var/www/html/

if [ -f "$phpinfo" ]; then
  rm "$phpinfo"
fi

echo "<?php phpinfo(); ?>" > phpinfo.php

if [ -f "$ixhtml" ]; then
  rm "$ixhtml"
fi

echo "<html>" >> $ixhtml
echo "<head>" >> $ixhtml
echo "<title>Welcome to rtexe</title>" >> $ixhtml
echo "<style>" >> $ixhtml
echo "    body {" >> $ixhtml
echo "        width: 35em;" >> $ixhtml
echo "        margin: 0 auto;" >> $ixhtml
echo "        font-family: Tahoma, Verdana, Arial, sans-serif;" >> $ixhtml
echo "    }" >> $ixhtml
echo "</style>" >> $ixhtml
echo "</head>" >> $ixhtml
echo "<body>" >> $ixhtml
echo "<h1>Welcome to rtexe</h1>" >> $ixhtml
echo "<p>If you see this page, the web server is successfully installed and" >> $ixhtml
echo "working. Further configuration may be required.</p>" >> $ixhtml
echo " " >> $ixhtml
echo "<p>For online documentation and support please refer to" >> $ixhtml
echo "<a href="https://github.com/Valikahn/rtexe">GitHub</a>.<br/>" >> $ixhtml
echo " " >> $ixhtml
echo "<p><em>Thank you for using rtexe.</em></p>" >> $ixhtml
echo "</body>" >> $ixhtml
echo "</html>" >> $ixhtml
echo "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
#---------------------------------------------------------------------------------------------------------#


#################################
##  Current Version Variables  ##
#################################
cd $HOME/rtexe
ftp_cur_ver=$(apt-cache policy vsftpd | grep -o Installed.* | cut -d ' ' -f2)
rt_cur_ver=$(rtorrent -h | grep -om 1 "[0-9]\{1,2\}\.[0-9]\{1,2\}\.[0-9]\{1,2\}")
ru_cur_ver=$(grep -m 1 version: /var/www/html/rutorrent/js/webui.js | cut -d \" -f2)
#---------------------------------------------------------------------------------------------------------#


###############################
##  Summary of Installation  ##
###############################
echo -n 'Generating User Output File'
cd $HOME/rtorrent
touch $outcred
sleep 5
echo
echo
echo "Summary of Installation (Important Information, please read)" | tee $outcred

echo | tee $outcred

echo "SSH Configured" | tee -a $outcred
echo "   SSH port set to $sshport" | tee -a $outcred
echo "   root login directly from SSH disabled"
echo "   login with $user and switch to root using: sudo su"

echo | tee -a $outcred

echo "FTP Server"  | tee -a $outcred
echo "   vsftpd $ftp_cur_ver installed" | tee -a $outcred
echo "   ftp port set to $vsftpd_port" | tee -a $outcred
echo "   ftp client should be set to explicit ftp over tls using port $vsftpd_port" | tee -a $outcred

echo | tee -a $outcred

echo "rtorrent torrent client" | tee -a $outcred
echo "   rtorrent $rt_current installed" | tee -a $outcred
echo "   crontab entries made. rtorrent and irssi will start on boot for $user" | tee -a $outcred

echo | tee -a $outcred

echo "RuTorrent Web GUI" | tee -a $outcred
echo "   RuTorrent $ru_current installed" | tee -a $outcred
echo "   rutorrent can be accessed at https://$ip/rutorrent" | tee -a $outcred
#echo "   rutorrent password set to $webpass" | tee -a $outcred
echo "   rutorrent password as set by user" | tee -a $outcred

echo | tee -a $outcred

echo "IMPORTANT: SSH Port set to $sshport" | tee -a $outcred
echo
echo "Please ensure you can login BEFORE closing this session"
echo
echo "The above information is stored in rtinst.info in your home directory."
echo "To see contents enter: cat $outcred"
echo
echo "PLEASE REBOOT YOUR SYSTEM ONCE YOU HAVE NOTED THE ABOVE INFORMATION"
echo | tee -a $outcred
echo "Thank You for choosing rtexe by valikahn" | tee -a $outcred
echo
chown $user $outcred
#echo "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
#---------------------------------------------------------------------------------------------------------#


#######################################
##  Return to User Interation Shell  ##
#######################################
cd $HOME
#---------------------------------------------------------------------------------------------------------#