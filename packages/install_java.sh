#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=java

echo "Java will be installed"

sudo apt-get update -q
sudo apt-get install -qq openjdk-11-jre

echo "JAVA is installed"