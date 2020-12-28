#! /bin/sh
# preload functions
cd $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd ) && cd .. && source ./functions.sh

# Installing package
echo "Installing Pi-hole"
curl -sSL https://install.pi-hole.net | bash
echo "PIHOLE DONE"