#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=kdenlive

# Installing package
echo "Installing Kdenlive"
install --dep $1 flatpak
flatpak install -y kdenlive
sudo ln -s ~/.local/share/flatpak/exports/share/applications/org.kde.kdenlive.desktop /usr/bin/kdenlive
echo "KDENLIVE DONE"
