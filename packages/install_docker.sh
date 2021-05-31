#! /bin/bash
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=docker

# Installing package
echo "Installing Docker"
if [[ $OS == "OSMC" ]]; then
	sudo apt-get update && sudo apt-get upgrade
	curl -sSL https://get.docker.com | sh
	sudo usermod -aG docker ${USER}
	groups ${USER}
	sudo apt-get install libffi-dev libssl-dev
	sudo apt install python3-dev
	sudo apt-get install -y python3 python3-pip
	sudo pip3 install docker-compose
	sudo systemctl enable docker
<< COMMENT
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker osmc
    docker version
    docker info
COMMENT
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
