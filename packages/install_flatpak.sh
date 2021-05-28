#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=flatpak

# Installing package
echo "Installing Flatpak"
sudo apt-get -qq update
sudo apt-get install -qq flatpak
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub
echo "FLATPAK DONE"
