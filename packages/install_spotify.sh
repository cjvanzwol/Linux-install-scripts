#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=spotify

# installing package
echo "Installing spotify"
get https://dtcooper.github.io/raspotify/raspotify-latest.deb
cpfile spotify /usr/local/bin/
echo "spotify DONE"
