#! /bin/sh
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/packages/.recall_functions

# Installing package
echo "Installing Pi-hole"
curl -sSL https://install.pi-hole.net | bash
echo "PIHOLE DONE"