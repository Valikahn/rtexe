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
echo -n 'Housekeeping of var/www/html'

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
#---------------------------------------------------------------------------------------------------------#


###################
##  FINAL TASKS  ##
###################
#echo "Setting permissions, Starting services, Finishing Up..."
#chown -R www-data:www-data /var/www/html
#chown -R $user:$user $HOME
#
#su $user -c '/etc/init.d/rtorrent-init restart'
#su $user -c '/etc/init.d/rtorrent-init -i restart'
#sudo service rtorrent-init restart
#---------------------------------------------------------------------------------------------------------#


#######################################
##  Return to User Interation Shell  ##
#######################################
cd $HOME/rtexe
#---------------------------------------------------------------------------------------------------------#