#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=gimp

# Installing package
echo "Installing Gimp"
sudo apt-get update -q
sudo apt-get install -qq gimp
echo "GIMP DONE"
