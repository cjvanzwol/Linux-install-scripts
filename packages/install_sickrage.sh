#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=sickrage

# Installing package
echo "Installing Sickrage"
if [[ $OS == "OSMC" ]]; then
    sudo apt install -y python3-cryptography python3-openssl python3-lxml python3-pip python3-setuptools python3-libxml2 python-libxslt1 
    if [[ -d /opt/sickrage ]]; then
        sudo git -C /opt/sickrage pull
    else
        sudo git clone https://git.sickrage.ca/SiCKRAGE/sickrage /opt/sickrage
    fi
    sudo pip3 install --no-deps -r /opt/sickrage/requirements.txt
    read -p "2"
    sudo python3 /opt/sickrage/SiCKRAGE.py
    read -p "3"
    sudo addgroup --system sickrage
    sudo adduser --disabled-password --system --home /opt/sickrage --gecos "SiCKRAGE" --ingroup sickrage sickrage chown sickrage:sickrage -R /opt/sickrage cp -v /opt/sickrage/runscripts/init.systemd /etc/systemd/system/sickrage.service
    sudo chown root:root /etc/systemd/system/sickrage.service
    sudo chmod 644 /etc/systemd/system/sickrage.service
    sudo systemctl enable sickrage
    sudo systemctl start sickrage
    sudo systemctl status sickrage
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
