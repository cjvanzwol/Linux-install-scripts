#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=thefuck

# Installing package
echo "Installing TheFuck"
sudo apt-get install -qq python3-dev python3-pip python3-setuptools
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo ln -s /usr/bin/pip3 /usr/bin/pip
sudo pip3 install -q thefuck
BASHRC=~/.bashrc
if [[ $(grep -Ril "function fuck ()" $BASHRC) != $BASHRC ]]; then
	echo "eval \"$(thefuck --alias)"\" >> $BASHRC
fi
echo "THEFUCK DONE"
