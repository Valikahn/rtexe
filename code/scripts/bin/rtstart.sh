#!/bin/bash
sleep 3
#---------------------------------------------------------------------------------------------------------#

###################################
##  rtorrent Start/Stop/Restart  ##
###################################
PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin:/sbin
SERVICE='rtorrent'
FILE="$HOME/rtorrent/.session/rtorrent.lock"

service_running(){
pgrep -fx -u $LOGNAME $1 > /dev/null
}

for SERVICE do
if ! ( service_running $SERVICE ); then
  if [[ $SERVICE = "rtorrent" && -a $FILE ]]; then
    rm -f $FILE
  fi
  screen -d -m -S $SERVICE $SERVICE
fi
done
#---------------------------------------------------------------------------------------------------------#