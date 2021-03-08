#! /bin/sh
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=pi-hole

# Installing package
echo "Installing Pi-hole"
curl -sSL https://install.pi-hole.net | bash
echo "PIHOLE DONE"