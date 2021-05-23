#! /bin/sh
#################################################
# This script should be run after fresh install #
#################################################
# variables & functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/functions.sh

##########################
# Start installing stuff #
##########################
title "Starting base setup"

if [ -f $PREFIX_/.base_done ]; then
    echo "Base-install has already been run. (remove .base_done to rerun)"
else
    FASE="base"
    if [[ $OS != "NAS" ]]; then
        # For Debian(-like) systems
        subtitle "Change password for $USER"
        sudo passwd $USER

        if [[ $OS == "ChromeOS" ]]; then
            subtitle "Upgrade container"
            sudo bash /opt/google/cros-containers/bin/upgrade_container
        else
            subsubtitle "Updating system"
            sudo apt-get update -q
            sudo apt-get upgrade -qq
            sudo apt-get dist-upgrade -y
        fi
        
        subtitle "Writing list of base-packages to ~/.base-packages"
        sudo apt list --installed > ~/.base-packages
        
        subtitle "Adding rules to apt.conf.d for minimal installation packages"
        cpfile 99_norecommends /etc/apt/apt.conf.d
        
        subtitle "Installing base-packages"
        #sudo apt --fix-broken install -y
        sudo apt-get install -qq nano
        install --dep git
        if [[ $OS == "ChromeOS" ]]; then
            sudo apt-get -qq install mesa-utils
        elif [[ $OS == "OSMC" ]]; then
            :
        elif [[ $OS == "Google Shell" ]]; then
            :
        fi
    elif [[ $OS == "NAS" ]]; then
        # For Synology DSM
        echo "no initial setup defined for $OS: nothing to do"
        curl -k https://bootstrap.pypa.io/get-pip.py | python
        pip install virtualenv
    else
        echo "Script not configured for $OS: exitting"
        exit 1
    fi

    # flagging base is done with empty file
    touch $PREFIX_/.base_done
    echo "--- Base setup DONE ---"
fi

###########
# PACKGES #
###########
title "Choose additional packages to install"

case $OS in
    ChromeOS)
        install gimp inkscape jupyterlab vscode firefox google-chrome docker adb fastboot
        ;;
    OSMC)
        install pi-hole gmediarender
        ;;
    NAS)
        install sickbeard couchpotato headphones
        ;;
    GoogleShell)
        install conda
        ;;
    *)
        install vscode nfs-client smb-server
        ;;
esac

title "Setup and installs are DONE. Exitting now."
exit 0
w."
exit 0
