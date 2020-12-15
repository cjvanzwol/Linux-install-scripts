#! /bin/sh
source PREFIX_/functions.sh

echo "Installing Pi-hole"
curl -sSL https://install.pi-hole.net | bash
echo "PIHOLE DONE"