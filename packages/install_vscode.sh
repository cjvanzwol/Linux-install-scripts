#! /bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
cd $PREFIX_

# Installing package
if [[ $OS == "ChromeOS" ]]; then
        echo "Installing Codile"
        get https://github.com/dimkr/codile/releases/download/latest/codile_0.0.1_amd64.deb

        echo "Codile DONE"
    else
        sudo apt-get install -qq codium
        echo "VSCODIUM DONE"
fi