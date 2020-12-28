#! /bin/sh
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/packages/.recall_functions

# Installing package
## Script to make syncthing autostart
echo "Installing Syncthing"
sudo apt-get update -q
sudo apt-get install -qq syncthing wget

# make syncthing autostart
# following instructions on https://docs.syncthing.net/users/autostart.html#linux using systemd
echo "setting autostart"
sudo cd /etc/systemd/system
sudo wget https://raw.githubusercontent.com/syncthing/syncthing/v1.6.1/etc/linux-systemd/system/syncthing%40.service
sudo mv syncthing@.service syncthing.service
sudo -u $USER sudo systemctl enable syncthing.service
sudo -u $USER sudo systemctl start syncthing.service
echo "SYNCTHING DONE"
# end