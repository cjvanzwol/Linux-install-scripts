#! /bin/sh
source PREFIX_/functions.sh

echo "Installing Gimp"
sudo apt-get update -q
sudo apt-get install -qq gimp
echo "GIMP DONE"