#!/bin/sh
source PREFIX_/functions.sh

echo "installing pushbullet-cli"
sudo apt-get update -qq
sudo apt-get install -qq python3
pip3 install -Uq pushbullet-cli
if [ $(pb list-devices) == "" ]; then
    pb set-key
fi
echo "Which devices should receive te notification?"
pb list-devices
read -p "[number] " pbd
pb push -d $pbd "Pushbullet-cli is set"
echo "PUSHBULLET DONE"