#! /bin/sh
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/packages/.recall_functions

# Installing package
echo "Installing Inkscape"
sudo apt-get update -q
sudo apt-get install -qq inkscape
echo "INKSCAPE DONE"