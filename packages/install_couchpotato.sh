#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=couchpotato

# Installing package

echo "Installing Couchpotato"
if [[ $OS == "OSMC" ]]
    echo "if you want to install couchpotato op pi, please creat scipt: nothing is done now"
elif [[ $OS == "NAS" ]]; then
    local dir=/volume1/@appstore/couchpotatoserver-custom
    if [[ -d $dir ]]; then
        read -p "Do you want to restore settings? [y/n] " s
        if [[ $s == "y" ]]; then
            cpfile settings.conf $dir/var
        fi
    fi
fi
<<<< HEAD
=======
elif [[ $OS == "OSMC" ]]
    echo "if you want to install couchpotato op pi, please creat scipt: nothing is done now"
>>>>>>> branch 'master' of https://github.com/cjvanzwol/Linux-install-scripts.git
fi
