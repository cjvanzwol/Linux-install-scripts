#! /bin/sh
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/.recall_functions

# Installing package
if [[ $OS == "ChromeOS" ]]; then
        echo "Installing Codile"
        get https://github.com/dimkr/codile/releases/download/0.0.1-862ea6d/codile_0.0.1_amd64.deb
	INSTALLED_APP="Codile"
else
        sudo apt-get install -qq codium
	INSTALLED_APP="Codium"
fi
echo "$INSTALLED_APP DONE"
