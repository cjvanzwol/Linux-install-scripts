#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=sickbeard

# Installing package
echo "Installing Sickbeard"
if [[ $OS == "OSMC" ]]; then
    sudo apt-get update -q
    sudo apt-get install -qq git-core python python-cheetah
    git clone https://github.com/SickRage/SickRage.git. ~/.sickrage
    sudo cp ~/.sickrage/runscripts/init.debian /etc/init.d/sickrage
    sudo chmod +x /etc/init.d/sickrage
    sudo cpfile sickrage.default /etc/default/sickrage
    sudo chmod +x /etc/default/sickrage
    sudo update-rc.d sickrage defaults
    sudo service sickrage start
elif [[ $OS == "NAS" ]]; then
    local dir=/volume1/@appstore/sickbeard-custom
    if [[ -d $dir ]]; then
        read -p "Do you want to restore settings? [y/n] " <s
        if [[ $s == "y" ]]; then
            cpfile config.ini $dir/var
        fi
  fi
fi== "OSMC" ]]
    echo "if you want to install sickbeard op pi, please creat scipt: nothing is done now"
fi