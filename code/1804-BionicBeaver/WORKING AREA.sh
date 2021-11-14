###########################################################################################################
############################  BELOW THIS LINE THERE ARE ERRORS WITH SOMETHING #############################
###########################################################################################################


#########################
##  Install ruTorrent  ##
#########################
echo 'Installing ruTorrent'
mkdir -p "$HOME"/$dirruTorrent
cd "$HOME"/rtexe/temp/ruTorrent
curl -sL $ruTorrent_dl -o ruTorrent-master.tar.gz > /dev/null
tar -zxvf ruTorrent-master.tar.gz > /dev/null
rm ruTorrent-master.tar.gz

if [ -d /var/www/html/rutorrent ]; then
		rm -r /var/www/html/rutorrent
fi

mv ruTorrent-master rutorrent
cp -r rutorrent /var/www/html/

chown -R www-data.www-data /var/www/html/rutorrent/
chmod -R 775 /var/www/html/rutorrent/

service apache2 restart
systemctl reload apache2

echo 'Configuring ruTorrent'
cd

echo '1'
rm /var/www/html/rutorrent/conf/config.php
cp -f $HOME/rtexe/config/ruTorrent.config /var/www/html/rutorrent/conf/config.php
mkdir -p /var/www/html/rutorrent/conf/users/$user/plugins
cd /var/www/html/rutorrent/conf/users/$user/plugins

echo '2'
echo "<?php" > config.php
echo >> config.php
echo "\$homeDirectory = \"$HOME\";" >> config.php
echo "\$topDirectory = \"$HOME\";" >> config.php
echo "\$scgi_port = 5000;" >> config.php
echo "\$XMLRPCMountPoint = \"/RPC2\";" >> config.php
echo >> config.php
echo "?>" >> config.php
cd ../../..

echo '3'
sudo mv plugins.ini plugins.ini.orig
sudo cp -f $HOME/rtexe/config/ruTorrent.ini /var/www/html/rutorrent/conf/plugins.ini
sudo cp -f $HOME/rtexe/config/rtorrent-init /etc/init.d/rtorrent-init

echo '4'
chmod +x /etc/init.d/rtorrent-init
# -i "s/USERNAMEHERE/$user/g" /etc/init.d/rtorrent-init
update-rc.d rtorrent-init defaults
service apache2 restart

echo '5'
sudo service apache2 restart
sudo /etc/init.d/rtorrent-init start
#---------------------------------------------------------------------------------------------------------#