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

echo "<html>" >> index.html
echo "<head>" >> index.html
echo "<title>Welcome to rtexe</title>" >> index.html
echo "<style>" >> index.html
echo "    body {" >> index.html
echo "        width: 35em;" >> index.html
echo "        margin: 0 auto;" >> index.html
echo "        font-family: Tahoma, Verdana, Arial, sans-serif;" >> index.html
echo "    }" >> index.html
echo "</style>" >> index.html
echo "</head>" >> index.html
echo "<body>" >> index.html
echo "<h1>Welcome to rtexe</h1>" >> index.html
echo "<p>If you see this page, the web server is successfully installed and" >> index.html
echo "working. Further configuration may be required.</p>" >> index.html
echo " " >> index.html
echo "<p>For online documentation and support please refer to" >> index.html
echo "<a href="https://github.com/Valikahn/rtexe">GitHub</a>.<br/>" >> index.html
echo " " >> index.html
echo "<p><em>Thank you for using rtexe.</em></p>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
echo "${GREEN}   [ Complete ]${NORMAL}"  ##  THIS IS AN EXPERIMENT
#---------------------------------------------------------------------------------------------------------#


####################################
##  Housekeeping of var/www/html  ##
####################################
echo -n 'Output File'
sleep 3

cd /var/www/html/
echo "<html>" >> outputUserDetails.html
echo "<title>Output User Details</title>" >> outputUserDetails.html
echo "<style>" >> outputUserDetails.html
echo "    body {" >> outputUserDetails.html
echo "        width: 35em;" >> outputUserDetails.html
echo "        margin: 0 auto;" >> outputUserDetails.html
echo "        font-family: Tahoma, Verdana, Arial, sans-serif;" >> outputUserDetails.html
echo "    }" >> outputUserDetails.html
echo "</style>" >> outputUserDetails.html
echo "</head>" >> outputUserDetails.html
echo "<body>" >> outputUserDetails.html
echo "<h1>Output User Details</h1>" >> outputUserDetails.html
echo "<p>SSH Configured  " >> outputUserDetails.html
echo "   SSH port set to $sshport" >> outputUserDetails.html
echo "   root login directly from SSH disabled" >> outputUserDetails.html
echo "   login with $user and switch to root using: sudo su</p>" >> outputUserDetails.html
echo " " >> outputUserDetails.html
echo "<p>FTP Server  " >> outputUserDetails.html
echo "   vsftpd $ftp_current installed" >> outputUserDetails.html
echo "   ftp port set to $ftpport" >> outputUserDetails.html
echo "   ftp client should be set to explicit ftp over tls using port $ftpport</p>" >> outputUserDetails.html
echo " " >> outputUserDetails.html
echo "<p>rtorrent torrent client  " >> outputUserDetails.html
echo "   rtorrent $rt_current installed" >> outputUserDetails.html
echo "   crontab entries made. rtorrent and irssi will start on boot for $user" >> outputUserDetails.html
echo " " >> outputUserDetails.html
echo "<p>RuTorrent Web GUI  " >> outputUserDetails.html
echo "   rutorrent can be accessed at https://$serverip/rutorrent" >> outputUserDetails.html
echo "   RuTorrent $ru_current installed" >> outputUserDetails.html
echo "   rutorrent password set to $webpass" >> outputUserDetails.html
echo " " >> outputUserDetails.html
echo "<p>Webmin Web GUI  " >> outputUserDetails.html
echo "   Webmin can be accessed at https://$serverip:10000" >> outputUserDetails.html
echo " " >> outputUserDetails.html
#---------------------------------------------------------------------------------------------------------#
echo "Please ensure you can login BEFORE closing this session" >> outputUserDetails.html
echo " " >> outputUserDetails.html
echo "The above information is stored in rtinst.info in your home directory." >> outputUserDetails.html
echo "To see contents enter: cat $home/rtinst.info" >> outputUserDetails.html
echo " " >> outputUserDetails.html
echo "To install webmin enter: sudo rtwebmin" >> outputUserDetails.html
echo " " >> outputUserDetails.html
echo "SCROLL UP IF NEEDED TO READ ALL THE SUMMARY INFO" >> outputUserDetails.html
echo "PLEASE REBOOT YOUR SYSTEM ONCE YOU HAVE NOTED THE ABOVE INFORMATION" >> outputUserDetails.html
echo "Thank You for choosing rtexe" >> outputUserDetails.html
echo " " >> outputUserDetails.html
#---------------------------------------------------------------------------------------------------------#


#######################################
##  Return to User Interation Shell  ##
#######################################
cd $HOME/rtexe
#---------------------------------------------------------------------------------------------------------#