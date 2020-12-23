#!/bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
cd $PREFIX_

# Installing package
echo "installing pushbullet-cli"
sudo apt-get update -qq
sudo apt-get install -qq python3 python3-pip
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo ln -s /usr/bin/pip3 /usr/bin/pip
pip3 install -Uq pushbullet-cli
if [ $(pb list-devices) == "" ]; then
    pb set-key
fi
echo "Which devices should receive te notification?"
pb list-devices
read -p "[number] " pbd
pb push -d $pbd "Pushbullet-cli is set"
echo "PUSHBULLET DONE"
