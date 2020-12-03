#! /bin/bash
#################################################
# This script should be run after fresh install #
#################################################
# variables
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )

# functions
title() { echo "------------------"; echo $1; }
subtitle() { echo; echo ">> $1"; }
subsubtitle() { echo; echo ">>>> $1"; }

cpfile() {
    local FILE=$PREFIX_/assets/$FASE/$1
    [[ ! -f $2/$1 ]] && \
        $([[ $(echo $(ls -dlG $2) | cut -d' ' -f 3) == "root" ]] && echo "sudo") \
        cp $FILE $2 && \
        echo "Copied $1 to $2"
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
    echo "other OS"
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
    if [[ $OS != "ChromeOS" ]]; then
        subtitle "Upgrade container"
        sudo bash /opt/google/cros-containers/bin/upgrade_container
    else
        subsubtitle "Updating system"
        sudo apt upgrade -qq
        sudo apt dist-upgrade -y
    fi
    #sudo apt autoremove --purge -qq
    
    subtitle "Writing list of base-packages to ~/.base-packages"
    sudo apt list --installed > ~/.base-packages
    
    subtitle "Adding rules to apt.conf.d for minimal installation packages"
    cpfile 99_norecommends /etc/apt/apt.conf.d
    
    subtitle "Installing base-packages"
    sudo apt update -qq
    sudo apt --fix-broken install -y
    sudo apt install -qq git nano
    if [[ $OS != "ChromeOS" ]]; then
        sudo apt install -qq mesa-utils
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
toInstall=()
question() {
    read -p "Do you want to install $1 [y/n] " a
    if [[ $a == "y" ]]; then
        toInstall+=( ${1} )
    fi
}

case $OS in
  ChromeOS)
    question gimp
    question jupyterlab
    question vscode
    question firefox
    question google-chrome
    ;;
  OSMC)
    question pihole
    ;;
  synology_monaco_ds216play | nas)
    echo "nothing to install"
    ;;
  *)
    question nfs-client
    question smb-server
    ;;
esac

<< COMMENT

install() { echo "$PREFIX_/packages/install_$1"; source $PREFIX_/packages/install_$1 }

title "Installing packages"
echo "array: ${toInstall[@]}"
for app in "${toInstall[@]}; do
    echo "Installing $app"
    install $app
done

if [[ $smb == "y" ]]; then
    source ./install_smb
    echo "SMB DONE"
fi
if [[ $j == "y" ]]; then
    source ./install_jupyter
    echo "JUPYTER DONE"
fi
if [[ $g == "y" ]]; then
    echo "Installing Gimp"
    sudo apt install -qq gimp
    echo "GIMP DONE"
fi
if [[ $ff == "y" ]]; then
    echo "Installing Firefox"
    sudo apt install flatpak
    flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install firefox
    echo "FIREFOX DONE"
fi
if [[ $vsc == "y" ]]; then
    if [[ $OS == "ChromeOS" ]]; then
        echo "Installing Codile"
        wget -q https://github.com/dimkr/codile/releases/download/0.0.1-862ea6d/codile_0.0.1_amd64.deb
        sudo apt install ./codile_0.0.1_amd64.deb
        rm codile_0.0.1_amd64.deb
    else
        sudo apt install -qq codium
    echo "GIMP DONE"
fi
if [[ $ph == "y" ]]; then
    if [[ $OS == "OSMC" ]]; then
        echo "Installing Pi-hole"
        curl -sSL https://install.pi-hole.net | bash
    echo "PIHOLE DONE"
fi


title "Setup and installs are DONE. Exitting now."
exit 0
COMMENT