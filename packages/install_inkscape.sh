#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=inkscape

# Installing package
echo "Installing Inkscape"
sudo apt-get update -q
sudo apt-get install -qq inkscape
echo "INKSCAPE DONE"