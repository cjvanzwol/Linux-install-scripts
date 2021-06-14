echo "deb http://ftp.debian.org/debian buster-backports main contrib" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update
sudo apt install torbrowser-launcher -t buster-backports -y
torbrowser-launcher

