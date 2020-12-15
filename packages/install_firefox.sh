#! /bin/sh
source PREFIX_/functions.sh

echo "Installing Firefox"
sudo apt-get -qq install flatpak
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install firefox
echo "FIREFOX DONE"