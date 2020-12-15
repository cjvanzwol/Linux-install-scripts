#! /bin/sh
source PREFIX_/functions.sh

echo "Headphones"
if [[ $OS == "NAS" ]]; then
    local dir=/volume1/@appstore/headphones
    if [[ -d $dir ]]; then
        read -p "Do you want to restore settings? [y/n] " s
        if [[ $s == "y" ]]; then
            cpfile config.ini $dir/var
        fi
elif [[ $OS == "OSMC" ]]
    echo "if you want to install sickbeard op pi, please creat scipt: nothing is done now"
fi