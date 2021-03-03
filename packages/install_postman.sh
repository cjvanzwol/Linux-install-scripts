#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=postman

# Installing package
echo "Installing Postman"
if [[ $OS == "ChromeOS" ]]; then
    get https://dl.pstmn.io/download/latest/linux64 /opt
    sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
    cpfile postman.desktop /usr/share/applications
else
    install --dep $1 flatpak
    flatpak install -y com.getpostman.Postman
fi
echo "POSTMAN DONE"