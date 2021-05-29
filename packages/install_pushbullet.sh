#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=pushbullet

# Installing package
echo "installing pushbullet-cli"
sudo apt-get update -qq
sudo apt-get install -qq python3 python3-pip
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo ln -s /usr/bin/pip3 /usr/bin/pip
pip3 install -q pushbullet-cli
export PATH="$HOME/.local/bin:$PATH"
if [ $(pb list-devices) == "" ]; then
    pb set-key
fi
echo "Which devices should receive te notification?"
pb list-devices
read -p "[number] " pbd
pb push -d $pbd "Pushbullet-cli is set"
echo "PUSHBULLET DONE"
