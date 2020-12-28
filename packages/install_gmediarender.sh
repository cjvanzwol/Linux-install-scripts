#! /bin/sh
# preload functions
cd $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd ) && cd .. && source ./functions.sh
# variables
DEFAULTS=/etc/default

# installing package
echo "Installing gmrender-resurrect"
sudo apt-get update -y
sudo apt-get install -qq libupnp6 gmediarender
sudo rm $DEFAULTS/gmediarender && cp gmediarender $DEFAULTS
sudo systemctl enable gmediarender
echo "GMRENDER-RESURRECT DONE"
