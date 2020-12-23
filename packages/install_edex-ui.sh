#! /bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
cd $PREFIX_

# Installing package
if [[ $OS == "ChromeOS" ]]; then
    echo "Installing eDex-UI"
    wget -q https://github.com/GitSquared/edex-ui/releases/download/v2.2.5/eDEX-UI-Linux-x86_64.AppImage
    chmod +x eDEX-UI-Linux-x86_64.AppImage
    ./eDEX-UI-Linux-x86_64.AppImage
    rm eDEX-UI-Linux-x86_64.AppImage
fi
echo "EDEX-UI DONE"