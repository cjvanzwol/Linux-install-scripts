#! /bin/sh
source PREFIX_/functions.sh

echo "Installing Gimp"
get https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo -u $USER xdg-settings set default-web-browser garcon_host_browser.desktop
echo "INKSCAPE DONE"