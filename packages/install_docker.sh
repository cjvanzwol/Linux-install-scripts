#! /bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
cd $PREFIX_

# Installing package
echo "Installing Docker"
sudo apt-get update -y
sudo apt-get install -qq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world #REMOVE AFTER DEBUG
echo "DOCKER DONE"