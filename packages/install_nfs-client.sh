#!/bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
cd $PREFIX_

# Installing package
echo "Install packages for NFS"
sudo apt-get update -qq
sudo apt-get install -qq nfs-common

read -p  "Mount NAS to /mnt/nas? [y/n] " mn
if [ $mn == "y" ]; then
	sudo mkdir /media/nas
	sudo chown -R $USER:$USER /media/nas
	read -p "What is the ip of the NAS? " nip
	if [[ $(sudo grep -Ril $nip /etc/fstab) == "/etc/fstab" ]]; then
        	echo "mountpoint for nfs-share on $ip already exists: no changes made"
		read -p "Do you want to edit /etc/fstab manually? [y/n] " man
		if [ $man == "y" ]; then
			sudo nano /etc/fstab
		fi
	else
		echo "$nip:/volume1   /mnt/media   nfs    rw  0  0" | sudo tee /etc/fstab -a
		sudo mount -a
	echo "NAS is added to fstab and mounted (or wil be mounted at next boot)"
	fi
fi

read -p "Use remote home folder on NAS? [y/n] " rh
if [ $rh == "y" ]; then
	REMOTE_HOME="/media/nas/homes/$USER/Drive/Knutselen/CROSTINI"
	mkdir $REMOTE_HOME
	mv /home/$USER $REMOTE_HOME
	ln -s $REMOTE_HOME /home/$USER
fi

read -p "Do you want to add another NFS-mount? [y/n] " an
if [ $an == "y"]; then
	read -p "Where schould the NFS-share be mounted? [/folder/name] " mf
	sudo mkdir $mf
	sudo chown -R $USER:$USER $mf
	read -p "What is the ip of the NFS-server? " ip
	if [[ $(sudo grep -Ril $ip /etc/fstab) == "/etc/fstab" ]]; then
                echo "mountpoint for nfs-share on $ip already exists: no changes made"
                read -p "Do you want to edit /etc/fstab manually? [y/n] " man
                if [ $man == "y" ]; then
                        sudo nano /etc/fstab
                else
                	read -p "What is the root folder of the NFS-share? [/foldername] " rf
      			echo "$ip:$rf   $mf   nfs    rw  0  0" | sudo tee /etc/fstab -a
                fi
        sudo mount -a
        echo "NAS is added to fstab and mounted (or wil be mounted at next boot)"
        fi
fi
echo "NFS DONE"