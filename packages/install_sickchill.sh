#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=sickrage

# Installing package
echo "Installing Sickrage"
if [[ $OS == "OSMC" ]]; then
	read -p "1=pip, 2=manual : " c
	if [[ $c == "1" ]]; then
		echo "pip"
		echo  "TEMPDIR=/mnt/backup/temp pip3 install -U sickchill"
		echo "not working"
	elif [[ $c ]]; then
		echo "manual"
		sudo apt-get update
		sudo apt-get upgrade -y
		sudo apt-get dist-upgrade -y
		sudo apt-get install python3-pip python3 python3-dev git libssl-dev libxslt1-dev libxslt1.1 libxml2-dev libxml2 libssl-dev libffi-dev build-essential -y
		sudo pip3 install pyopenssl
		read -p "pre compiled unrar"
		wget http://sourceforge.net/projects/bananapi/files/unrar_5.2.6-1_armhf.deb
		sudo dpkg -i unrar_5.2.6-1_armhf.deb
		read
	else
		echo "else"
	fi
elif [[ $OS == "NAS" ]]; then
    local dir=/volume1/@appstore/sickbeard-custom
    if [[ -d $dir ]]; then
        read -p "Do you want to restore settings? [y/n] " <s
        if [[ $s == "y" ]]; then
            cpfile config.ini $dir/var
        fi
  fi
fi
echo "SICKRAGE DONE"
