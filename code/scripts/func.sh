#!/bin/bash

#---------------------------------------------------------------------------------------------------------#

# Copy files to where they need to be
cd ~
cd $HOME/rtorrent
touch $outcred
cd ~
cp -r $HOME/rtexe /etc
cp -r $rtstart /usr/local/bin/
chmod +x /usr/local/bin
cd $HOME
#---------------------------------------------------------------------------------------------------------#

# Are the sites up or down where we get our packages from?
up_or_down() {
  if [[ `wget -S -T 3 --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then return 0; else return 1; fi
}
#---------------------------------------------------------------------------------------------------------#

# Function to check if user name is a valid UNIX.
valid_name(){
    until [[ $user =~ ^[a-z][-a-z0-9_]{2,31}$ ]]
      do
        echo "Enter user name (lowercase, numbers, dash and underscore):"
        read user
      done
}
#---------------------------------------------------------------------------------------------------------#

# Random password generator function
passgen() {
	local genln=$1
	[ -z "$genln" ] && genln=8
	tr -dc A-Za-z0-9 < /dev/urandom | head -c ${genln} | xargs
	}
#---------------------------------------------------------------------------------------------------------#

# Function to set a user input password
set_pass() {
local authpass
local bailoutval=0
local passcheck
local passcheckagain

exec 3>&1 >/dev/tty

echo "Enter a password (6+ chars) or leave blank to generate a random one"

while [ -z $authpass ]
do
  echo "Please enter the new password:"
  stty -echo
  read passcheck
  stty echo
#---------------------------------------------------------------------------------------------------------#

# Check that password is valid
  if [ -z $passcheck ]; then
    echo "Random password generated, will be provided to user at end of script"
    bailoutval=1
    authpass=$(passgen)
  elif [ ${#passcheck} -lt 6 ]; then
    echo "password needs to be at least 6 chars long" && continue
  else
    echo "Enter the new password again:"
    stty -echo
    read passcheckagain
    stty echo
#---------------------------------------------------------------------------------------------------------#

# Check both passwords match
    if [ $passcheck != $passcheckagain ]; then
      echo "Passwords do not match"
    else
      authpass=$passcheck
    fi
  fi
done

exec >&3-
echo $authpass
return $bailoutval
}

# Function to determine random number between 2 numbers
random()
{
    local min=$1
    local max=$2
    local RAND=`od -t uI -N 4 /dev/urandom | awk '{print $2}'`
    RAND=$((RAND%((($max-$min)+1))+$min))
    echo $RAND
}
#---------------------------------------------------------------------------------------------------------#

# Function to ask user for y/n response
ask_user(){
local answer
while true
  do
    read answer
    case $answer in [Yy]* ) return 0 ;;
                    [Nn]* ) return 1 ;;
                        * ) echo "Enter y or n";;
    esac
  done
}
#---------------------------------------------------------------------------------------------------------#

# Function to enter IP address
enter_ip() {
local ip=$1

exec 3>&1 >/dev/tty

while true
  do
    if valid_ip $ip ; then
      echo "Your Server IP is $ip"
      echo -n "Is this correct y/n? "
      ask_user && break
    else
      echo "Invalid IP address, please try again"
    fi

    echo "enter your server's IP address"
    echo "e.g. 213.0.113.113"
    read ip
  done

exec >&3-

echo $ip
}
#---------------------------------------------------------------------------------------------------------#