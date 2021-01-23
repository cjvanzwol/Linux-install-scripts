#! /bin/bash
# Installscript for anaconda/miniconda.

# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/packages/.recall_functions

# check if app already is installed
if [[ -d /opt/conda ]]; then
        echo "It seems (mini/ana)conda is alreay installed in /opt. Please update from application."
        echo "Skipping download and install"
else
        echo "Installing conda"
        read -p "Install Anaconda of Miniconda? (miniconda is deafault) [anaconda/miniconda] " am
        if [[ $am != "anaconda" ]]; then
                echo "Installing miniconda3"
                echo "Installling miniconda"
                echo "NB choose install location /opt/conda" #7 #8
                cd ~
                wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
                sudo bash Miniconda3-latest-Linux-x86_64.sh
                # edit install script with sed to not prompt for values, but my values are pre inputted
                rm Miniconda3-latest-Linux-x86_64.sh
                echo "Miniconda is installed"
        else
                curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
                sudo install -o root -g root -m 644 conda.gpg /etc/apt/trusted.gpg.d/
                echo "deb [arch=amd64] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee /etc/apt/sources.list.d/conda.list
                rm conda.gpg
                sudo apt-get update -q
                sudo apt-get install -qq conda
                sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
                echo "Anaconda is installed"

        fi
fi

sudo chown -R $USER /opt/conda
mkdir /opt/conda/envs/
ls -hal /opt/conda/envs
conda config --add channels conda-forge
#conda init # add init to .bashrc for user
sudo /opt/conda/bin/conda init # add init to .bashrc for root

echo "Conda is installed"