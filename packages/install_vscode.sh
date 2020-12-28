#! /bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
#X=1
until [[ $PREFIX_ == *Linux-install-scripts ]]; do
  PREFIX_=$( echo "$PREFIX_" | sed 's/.$//' )
  #echo $X && ((X=$X+1))
done
source $PREFIX_/functions.sh

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
