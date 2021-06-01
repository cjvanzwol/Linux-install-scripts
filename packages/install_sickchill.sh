#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=sickrage

# Installing package
echo "Installing Sickrage"
if [[ $OS == "OSMC" ]]; then
    read -p "osmc or pi" d
    if [[ $d == "osmc" ]; then
    #FRom: https://discourse.osmc.tv/t/how-to-install-couchpotato-and-sickchill-on-raspberry-pi/10788
        sudo useradd sickchill
        sudo usermod -a -G osmc sickchill
        cd /opt/
        sudo git clone https://github.com/SickChill/SickChill.git sickchill
        sudo cp sickchill/contrib/runscripts/init.systemd /etc/systemd/system/sickchill.service
        sudo chown -R sickchill:sickchill /opt/sickchill
        #sudo systemctl enable sickchill.service
        sudo systemctl start sickchill.service
    if [[ $d == "pi" ]]; then
        appDir=/opt/sickchill
        # Form: https://www.htpcguides.com/install-sickrage-raspberry-pi-usenet-torrent-tv/    
        sudo apt-get update -qq
        sudo apt-get dist-upgrade -y -qq
        sudo apt-get install python3-pip python3 python3-dev git libssl-dev libxslt1-dev libxslt1.1 libxml2-dev libxml2 libssl-dev libffi-dev build-essential -y -qq
        sudo pip3 install -q pyopenssl
        get http://sourceforge.net/projects/bananapi/files/unrar_5.2.6-1_armhf.deb
        git clone https://github.com/SickRage/SickRage.git $appDir
        sudo chown -R $USER:$USER $appDir
        
        cpfile sickrage /etc/default
        sudo cp $appDir/runscripts/init.debian /etc/init.d/sickchill
        sudo chmod +x /etc/init.d/sickchill
        sudo update-rc.d sickchill defaults
        if
    fi

    echo "not working:"
    echo  "-pip install: TEMPDIR=/mnt/backup/temp pip3 install -U sickchill"
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