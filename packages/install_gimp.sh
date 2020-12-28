#! /bin/sh
# preload functions
cd $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd ) && cd .. && source ./functions.sh

# Installing package
echo "Installing Gimp"
sudo apt-get update -q
sudo apt-get install -qq gimp
echo "GIMP DONE"