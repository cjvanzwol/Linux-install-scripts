#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=couchpotato

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