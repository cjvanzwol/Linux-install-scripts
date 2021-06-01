#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=vscode

# Installing package
if [[ $OS == "ChromeOS" ]]; then
    echo "Installing Codile"
    #get https://github.com/dimkr/codile/releases/download/0.0.1-862ea6d/codile_0.0.1_amd64.deb
    get https://github.com/dimkr/codile/releases/download/0.0.1-v10-amd64/codile_0.0.1_amd64.deb
    sudo ln -s /usr/bin/codile /usr/bin/vscode
	INSTALLED_APP="Codile"
else
    sudo apt-get install -qq codium
	INSTALLED_APP="Codium"
fi
echo "$INSTALLED_APP DONE"
