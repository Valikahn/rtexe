#!/bin/bash
#---------------------------------------------------------------------------------------------------------#

##########################
###  USER INTERACTION  ###
##########################

# Set and prepare user
if [ -z "$user" ]; then
  if [ "$SUDO_USER" = "root" ] || [ -z "$SUDO_USER" ]; then
    echo "Please enter the name of the user account you would like to use."
	echo "This is where the program will install everything to."
    echo "This will be your primary user, this can be an existing user or a new user."
    echo
    auth_act=1
    while [ $auth_act = 1 ]
      do
        valid_name
		echo
        echo "You have entered $user as your chosen username."
		echo "Please confirm if this is corect y/n?"
        if ask_user; then
          auth_act=0
        else
          user=''
        fi
      done
  else
    user=$SUDO_USER
  fi
else
  if ! [[ $user =~ ^[a-z][-a-z0-9_]{2,31}$ ]]; then
    echo "$user is not a valid user name please enter again"
    auth_act=1
    while [ $auth_act = 1 ]
      do
        valid_name
        echo -n "You have entered $user as your chosen username."
		echo -n "Please confirm if this is corect y/n?"
        if ask_user; then
          auth_act=0
        else
          user=''
        fi
      done
  fi
fi

echo
echo "User name set to:  $user"
echo

if id -u $user >/dev/null 2>&1; then
  echo "$user already exists"
else
  if [ -z "$unixpass" ]; then
    adduser --gecos "" $user
  else
    adduser --gecos "" $user --disabled-password
    echo "$user:$unixpass" | chpasswd
  fi

  if id -u $user >/dev/null 2>&1; then
    echo "$user successfully created"
  else
    echo "create user failed - exiting process"
    exit 1
  fi

fi
#---------------------------------------------------------------------------------------------------------#

# Set password for rutorrent
###
if [ -z "$webpass" ] && [ $forceyes = 0 ]; then
  if [ -z $(grep -s $user $passfile) ]; then
    webpass=$(passgen)
    passflag=1
  else
    passflag=2
  fi
fi

#if [ -z "$webpass" ]  && [ $passflag != 2 ]; then
#  if [ ! -z $(grep -s $user $passfile) ]; then
#    echo "There is an existing RuTorrent password for $user"
#    echo -n "Use existing password y/n ? "
#    if ask_user; then
#      passflag=2
#    fi
#  fi
#  
#  if [ $passflag != 2 ]; then
#    echo "Set Password for RuTorrent web client"
#    webpass=$(set_pass)
#    passflag=$?
#  fi
#fi

echo
if [ $passflag != 2 ]; then
	echo "Set Password for RuTorrent web client"
	webpass=$(set_pass)
	passflag=$?
fi

rut_user_list=$(ls /var/www/html/rutorrent/conf/users 2>/dev/null | sed "s/$user//g")

for rut_user in $rut_user_list; do
  if ! id -u $rut_user >/dev/null 2>&1; then
    rut_user_list=$(echo $rut_user_list | sed "s/$rut_user//g")
  fi
done
#---------------------------------------------------------------------------------------------------------#

# Check required web repos are accessible
sed  -i "s/\/debian\s/\/debian\/ /g" /etc/apt/sources.list

echo
echo  "Checking $OS mirrors"
for i in $(cat /etc/apt/sources.list | grep "^deb http" | cut -d' ' -f2 | uniq ); do
  echo -n $i": "
  up_or_down $i && echo "${GREEN}[  OK  ]${NORMAL}" || { echo "${RED}[  FAIL  ]${NORMAL}"; os_prereq=1; }
done

echo
echo "Checking major 3rd party components"
echo -n "Rtorrent: "; up_or_down $rt_url && echo "${GREEN}[  OK  ]${NORMAL}" || { echo "${RED}[  FAIL  ]${NORMAL}"; prereq=1; }
echo -n "libtorrent: "; up_or_down $lib_url && echo "${GREEN}[  OK  ]${NORMAL}" || { echo "${RED}[  FAIL  ]${NORMAL}"; prereq=1; }
echo -n "xmlrpc-c: ";up_or_down $xmlrpc_url && echo "${GREEN}[  OK  ]${NORMAL}" || { echo "${RED}[  FAIL  ]${NORMAL}"; prereq=1; }
echo -n "RuTorrent: ";up_or_down $ru_url && echo "${GREEN}[  OK  ]${NORMAL}" || { echo "${RED}[  FAIL  ]${NORMAL}"; prereq=1; }
echo -n "Autodl-irssi: "; up_or_down $adl_url && echo "${GREEN}[  OK  ]${NORMAL}" || { echo "${RED}[  FAIL  ]${NORMAL}"; prereq=1; }

if [ $os_prereq = 1 ]; then
  echo "Some of the $OS mirrors are down, try again later"
  exit 1
fi

if [ $prereq = 1 ]; then
  echo "Some of the repositories we need are not currently available."
  echo "We will continue for now, but may not be able to finish or this will finish with errors."
fi
echo
#---------------------------------------------------------------------------------------------------------#

# Determine domain name using server ip address
export reverse=$(perl -MSocket -le "print((gethostbyaddr(inet_aton('$serverip'), AF_INET))[0])")
if [ -z "$reverse" ]; then
  echo "Unable to determine domain"
  echo "You IP Address is:  $ip"
  echo
else
  echo "Your domain is set to $reverse"
  echo "You IP Address is:  $ip"
  echo
fi
#---------------------------------------------------------------------------------------------------------#

# Including user to SUDO group of users
if groups $user | grep -q -E ' sudo(\s|$)'; then
  echo "${PURPLE}$user${NORMAL} already has sudo privileges"
else
  adduser $user sudo
  echo
  echo "${PURPLE}$user${NORMAL} added to the sudo group of users"
  echo "${RED}WARNING:  With great power comes great responsibility${NORMAL}"
fi
sleep 5
#---------------------------------------------------------------------------------------------------------#

# Final warning to the user user
echo
echo "${BOLD}OK, Lets get started - This is your last change to change your mind.${NORMAL}"
echo "${BOLD}Are you happy to proceed? [y,n]${NORMAL}"
read val

if [ "$val" == "" ]; then
	clear
	echo "Invalid entry by user...Terminating program..."
	sleep 5
	
elif [[ "$val" == "y" ]] || [[ "$val" == "yes" ]]; then

	clear
	echo -n "Please pick your Operating System version: "
	echo
		echo "${GREEN}$bb_1804${NORMAL}"
		echo "${LBLUE}$ff_2004${NORMAL}"
		echo "${PURPLE}$hh_2104${NORMAL}"
		echo "${YELLOW}$ii_2110${NORMAL}"
		echo "${BOLD}$osnot_listed${NORMAL}"
		echo
	read OSVERSION
	clear
	case $OSVERSION in

	  1)
		echo -n "You have chosen your Operating System version as Ubuntu 18.04 (Bionic Beaver)"
		source $intermess
		source $bb_pack_1804
		source $bb_func_1804
		source $bb_comp_1804
		echo
		echo "DONE!"
		;;

	  2)
		echo -n "You have chosen your Operating System version as Ubuntu 20.04 (Focal Fossa)"
		source $intermess
		source $ff_pack_2004
		source $ff_func_2004
		source $ff_comp_2004
		echo
		echo "DONE!"
		;;

	  3)
		echo -n "You have chosen your Operating System version as Ubuntu 21.04 (Hirsute Hippo)"
		source $intermess
		source $hh_pack_2104
		source $hh_func_2104
		source $hh_comp_2104
		echo
		echo "DONE!"
		;;
		
	  4)
		echo -n "You have chosen your Operating System version as Ubuntu 21.10 (Impish Indri)"
		source $intermess
		source $ii_pack_2110
		source $ii_func_2110
		source $ii_comp_2110
		echo
		echo "DONE!"
		;;

	  5)
		echo -n "Operating System Version Not Listed"
		echo
		exit 1
		;;
		
	  *)
		echo -n "Unknown Operating System"
		echo
		exit 1
		;;
	esac
	
fi
#---------------------------------------------------------------------------------------------------------#