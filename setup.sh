#! /bin/bash
#################################################
# This script should be run after fresh install #
#################################################
# variables
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
toInstall=()

# functions
title() { echo "------------------"; echo $1; }
subtitle() { echo; echo ">> $1"; }
subsubtitle() { echo; echo ">>>> $1"; }
cpfile() {
    mkdir -p $2 || echo "retrying with sudo" && sudo mkdir -p $2 && echo "it worked! continuing now"
    local FILE=$PREFIX_/assets/$FASE/$1
}

install() {
  toInstall=()
  for app in $@; do
    read -p "Do you want to install $app [y/n] " a
    if [[ $a == "y" ]]; then
      toInstall+=( $app )
    fi
  done

  for app in "${toInstall[@]}"; do
    FASE=$app
    echo $FASE
    source $PREFIX_/packages/install_$app.sh
  done
}
get() {
  wget -q -O i.deb $1
        sudo apt install ./i.deb
        rm i.deb
}

#############################
# check which OS is running #
#############################
case $(uname -n) in
  penguin)
    OS="ChromeOS"
    ;;
  osmc)
    OS="OSMC"
    ;;
  synology_monaco_ds216play | nas)
    OS="NAS"
    ;;
  *)
    OS="other OS"
    ;;
esac
title "Setting up Linux for $OS"

##########################
# Start installing stuff #
##########################
title "Starting base setup"
FASE="base"
if [[ $OS != "NAS" ]]; then
    # For Debian(-like) systems
    subtitle "Change password for $USER"
    #sudo passwd $USER

    if [[ $OS != "ChromeOS" ]]; then
        subtitle "Upgrade container"
        sudo bash /opt/google/cros-containers/bin/upgrade_container
    else
        subsubtitle "Updating system"
        sudo apt update -q
        sudo apt upgrade -qq
        sudo apt dist-upgrade -y
    fi
    #sudo apt autoremove --purge -qq
    
    subtitle "Writing list of base-packages to ~/.base-packages"
    sudo apt list --installed > ~/.base-packages
    
    subtitle "Adding rules to apt.conf.d for minimal installation packages"
    cpfile 99_norecommends /etc/apt/apt.conf.d
    
    subtitle "Installing base-packages"
    #sudo apt --fix-broken install -y
    sudo apt install -qq nano #git
    if [[ $OS != "ChromeOS" ]]; then
        sudo apt -y -qq install mesa-utils
    elif [[ $OS != "OSMC" ]]; then
        echo "No specific additional packages specified for $OS packages"
    fi
elif $OS == "NAS"; then
    # For Synology DSM
    echo "no initial setup defined for $OS: nothing to do"
fi
echo "--- Base setup DONE ---"

###########
# PACKGES #
###########
title "Choose additional packages to install"

case $OS in
  ChromeOS)
    install thefuck gimp jupyter vscode firefox google-chrome
    ;;
  OSMC)
    install pihole
    ;;
  synology_monaco_ds216play | nas)
    install sickbeard couchpotato headphones
    ;;
  *)
    install nfs-client smb-server
    ;;
esac

title "Setup and installs are DONE. Exitting now."
exit 0