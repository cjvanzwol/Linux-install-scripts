#! /bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
#cd $PREFIX_
DEFAULTS=/etc/default

# installing package
echo "Installing gmrender-resurrect"
sudo apt-get update -y
sudo apt-get install -qq libupnp6 gmediarender
sudo rm $DEFAULTS/gmediarender
cp gmediarender $DEFAULTS
sudo systemctl enable gmediarender
echo "GMRENDER-RESURRECT DONE"
