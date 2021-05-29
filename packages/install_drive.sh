#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=drive

# Installing package
echo "Installing Synology Drive"
get https://global.download.synology.com/download/Utility/SynologyDriveClient/2.0.4-11112/Ubuntu/Installer/x86_64/synology-drive-client-11112.x86_64.deb
echo "SYNOLOGY DRIVE DONE"
