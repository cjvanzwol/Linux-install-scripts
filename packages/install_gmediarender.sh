#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=gmediarender

# variables
DEFAULTS=/etc/default

# installing package
echo "Installing gmrender-resurrect"
sudo apt-get update -y
sudo apt-get install -qq libupnp6 gmediarender
sudo rm $DEFAULTS/gmediarender && cp gmediarender $DEFAULTS
sudo systemctl enable gmediarender
echo "GMRENDER-RESURRECT DONE"
