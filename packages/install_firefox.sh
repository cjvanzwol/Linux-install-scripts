#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=firefox

# Installing package
echo "Installing Firefox"
install --dep $1 flatpak
flatpak install -y firefox
sudo ln -s ~/.local/share/flatpak/exports/share/applications/org.mozilla.firefox.desktop /usr/bin/firefox

echo "FIREFOX DONE"
