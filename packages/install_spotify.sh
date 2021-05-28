#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=spotify

# installing package
echo "Installing spotify"
get https://dtcooper.github.io/raspotify/raspotify-latest.deb
echo "dummy file for Linux-install-scripts. Check https://github.com/cjvanzwol/Linux-install-scripts" > /usr/local/bin/spotify
echo "spotify DONE"
