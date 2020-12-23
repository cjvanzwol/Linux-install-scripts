#! /bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
cd $PREFIX_

# Installing package
echo "Installing Pi-hole"
curl -sSL https://install.pi-hole.net | bash
echo "PIHOLE DONE"