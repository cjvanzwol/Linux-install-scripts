#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=fastboot

# Installing package
echo "Installing fastboot"
sudo apt-get update -q
sudo apt-get install -qq fastboot
echo "FASTBOOT DONE"