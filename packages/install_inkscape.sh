#! /bin/sh
source PREFIX_/functions.sh

echo "Installing Gimp"
sudo apt update -q
sudo apt install -qq inkscape
echo "INKSCAPE DONE"