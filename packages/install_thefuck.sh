#! /bin/bash
echo "Installing TheFuck"
sudo apt-get install -qq python3-dev python3-pip python3-setuptools
sudo pip3 install -q thefuck
echo "THEFUCK DONE"