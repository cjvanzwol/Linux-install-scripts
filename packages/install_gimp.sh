#! /bin/sh
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/packages/.recall_functions

# Installing package
echo "Installing Gimp"
sudo apt-get update -q
sudo apt-get install -qq gimp
echo "GIMP DONE"