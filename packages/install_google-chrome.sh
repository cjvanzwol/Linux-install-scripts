#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=google-chrome

# Installing package
echo "Installing Google Chomre"
get https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo -u $USER xdg-settings set default-web-browser garcon_host_browser.desktop
echo "GOOGLE CHROME DONE"