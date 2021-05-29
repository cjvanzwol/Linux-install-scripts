#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=sickrage

# Installing package
echo "Installing Sickrage"
if [[ $OS == "OSMC" ]]; then
    #sudo apt-get install -qq git-core python python-cheetah
    sudo apt install git python3-cryptography python3-openssl python3-lxml python3-pip
    git clone https://git.sickrage.ca/SiCKRAGE/sickrage /opt/sickrage
    pip3 install --no-deps -r /opt/sickrage/requirements.txt
    python3 /opt/sickrage/SiCKRAGE.py
    addgroup --system sickrage
    adduser --disabled-password --system --home /opt/sickrage --gecos "SiCKRAGE" --ingroup sickrage sickrage chown sickrage:sickrage -R /opt/sickrage cp -v /opt/sickrage/runscripts/init.systemd /etc/systemd/system/sickrage.service
    chown root:root /etc/systemd/system/sickrage.service
    chmod 644 /etc/systemd/system/sickrage.service
    systemctl enable sickrage
systemctl start sickrage
systemctl status sickrage
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
ne now"
fi
RAGE DONE"
ne now"
fi
