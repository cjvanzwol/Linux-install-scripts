#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=git

# Installing package
echo "Installing git"
sudo apt-get update -q
sudo apt-get install -qq git
# setting up git
[[ -z $(git config --get user.email) ]] && read -p "Enter e-mail adres for git [you@example.com]: " gite && git config --global user.email "$gite"
[[ -z $(git config --get user.name) ]] && read -p "Enter name for git [John Doe]: " gitn && git config --global user.name "$gitn"

#ghcli=/home/linuxbrew/.linuxbrew/bin/gh
#read -p "Enter Github username: " ghu

#cloneRepo $ghu

echo "ADB DONE"


