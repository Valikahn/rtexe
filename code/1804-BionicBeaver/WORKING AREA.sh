###########################################################################################################
############################  BELOW THIS LINE THERE ARE ERRORS WITH SOMETHING #############################
###########################################################################################################


########################
##  Install rTorrent  ##
########################
echo 'Installing rTorrent'
mkdir -p "$HOME"/$dirrTorrent
cd "$HOME"/rtexe/temp/rTorrent
sudo apt-get -yqqf install rtorrent libtorrent19 libxmlrpc-core-c3
curl -sL $rTorrent_dl -o rtorrent.tar.gz > /dev/null
tar -zxvf rtorrent.tar.gz > /dev/null
rm rtorrent.tar.gz
cd rtorrent-0.9.8
./autogen.sh > /dev/null 2>&1
./configure --with-xmlrpc-c > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1
ldconfig > /dev/null 2>&1

cd $HOME

sudo mkdir -p /var/www/source
sudo mkdir -p /var/www/source/files
sudo mkdir -p /var/www/source/watch
sudo mkdir -p /var/www/source/.session

sudo chown -R www-data:www-data /var/www/source
sudo chmod 775 -R /var/www/source

sudo chown $user:$user -R /var/www/source
sudo chown $user:$user -R /var/www/source/files
sudo chown $user:$user -R /var/www/source/watch
sudo chown $user:$user -R /var/www/source/.session

sudo cp -f $HOME/rtexe/config/rtorrent.rc $HOME/.rtorrent.rc
sudo chown $user:$user "$HOME"/.rtorrent.rc

sudo cp -f $HOME/rtexe/config/rtorrent.service /etc/systemd/system/rtorrent.service
sudo sed -i "s/USERNAMEHERE/$user/g" /etc/systemd/system/rtorrent.service
sudo systemctl enable rtorrent.service
sudo systemctl start rtorrent

##  NEW BELOW THIS LINE  ##
#sed -i "s@HOMEDIRHERE@$HOME@g" $HOME/.rtorrent.rc
#---------------------------------------------------------------------------------------------------------#


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