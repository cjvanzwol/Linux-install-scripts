#!/bin/bash

read -p "Do you want to get notification with Pushbullet? [y/n] " pbn
if [[ $pbn == "y" ]]; then
	echo "installing pushbullet-cli"
	sudo apt update -qq
	sudo apt install python3 -qq
	pip3 install -Uq pushbullet-cli
	if [ $(pb list-devices) == "" ]; then
        pb set-key
    fi
    echo "Which devices should receive te notification?"
    pb list-devices
    read -p "[number] " pbd
    pb push -d $pbd "Pushbullet-cli is set"
fi