#! /bin/sh
# preload functions
PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
cd $PREFIX_ && cd ..
source ../functions.sh
#cd $PREFIX_

# installing package
echo "Installing gmrender-resurrect"
sudo apt-get update -y
sudo apt-get install -qq git build-essential autoconf automake libtool pkg-config
sudo apt-get install -qq libupnp-dev libgstreamer1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-alsa
git clone https://github.com/hzeller/gmrender-resurrect.git
cd gmrender-resurrect
./autogen.sh
./configure
make
sudo make install
echo "GMRENDER-RESURRECT DONE"