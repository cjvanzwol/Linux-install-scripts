#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=docker

# Installing package
echo "Installing Docker"
if [[ $OS == "OSMC" ]]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker osmc
    docker version
    docker info
else
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
fi
sudo docker run hello-world #REMOVE AFTER DEBUG
echo "DOCKER DONE"
=====
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world #REMOVE AFTER DEBUG
>>>>>>> branch 'master' of https://github.com/cjvanzwol/Linux-install-scripts.git
echo "DOCKER DONE"
