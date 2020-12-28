#! /bin/sh
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/.recall_functions

# Installing package
echo "Installing Gimp"
get https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo -u $USER xdg-settings set default-web-browser garcon_host_browser.desktop
echo "INKSCAPE DONE"