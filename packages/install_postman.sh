#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=postman

# Installing package
echo "Installing Postman"
install --dep $1 flatpak
flatpak install -y com.getpostman.Postman
echo "POSTMAN DONE"
