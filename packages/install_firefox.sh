#! /bin/bash
echo "Installing Firefox"
sudo apt install flatpak
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install firefox
echo "FIREFOX DONE"