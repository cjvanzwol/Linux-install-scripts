#! /bin/sh
source PREFIX_/functions.sh

echo "Installing TheFuck"
sudo apt-get install -qq python3-dev python3-pip python3-setuptools
sudo pip3 install -q thefuck
BASHRC=~/.bashrc
if [[ $(grep -Ril "function fuck ()" $BASHRC) != $BASHRC ]]; then
	echo "eval \"$(thefuck --alias)"\" >> $BASHRC
fi
echo "THEFUCK DONE"
