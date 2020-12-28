#! /bin/sh
# preload functions
cd $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd ) && cd .. && source ./functions.sh

# Installing package
echo "Installing Gimp"
sudo apt update -q
sudo apt install -qq inkscape
echo "INKSCAPE DONE"