#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=adb

# Installing package
echo "Installing adb"
sudo apt-get update -q
sudo apt-get install -qq adb
echo "ADB DONE"