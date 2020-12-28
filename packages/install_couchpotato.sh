#! /bin/sh
# preload functions
cd $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd ) && cd .. && source ./functions.sh

# Installing package
echo "Couchpotato"
if [[ $OS == "NAS" ]]; then
    local dir=/volume1/@appstore/couchpotatoserver-custom
    if [[ -d $dir ]]; then
        read -p "Do you want to restore settings? [y/n] " s
        if [[ $s == "y" ]]; then
            cpfile settings.conf $dir/var
        fi
    fi
elif [[ $OS == "OSMC" ]]
    echo "if you want to install couchpotato op pi, please creat scipt: nothing is done now"
fi