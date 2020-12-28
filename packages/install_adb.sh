#! /bin/sh
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/.recall_functions

# Installing package
echo "Installing adb"
sudo apt-get update -q
sudo apt-get install -qq adb
echo "ADB DONE"