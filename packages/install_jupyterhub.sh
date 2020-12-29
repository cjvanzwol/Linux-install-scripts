#! /bin/sh
# DEBUG
sudo rm /usr/bin/python /usr/bin/pip /etc/systemd/system/jupyterhub.service /usr/share/applications/jupyterhub.desktop /etc/profile.d/conda.sh
sudo rm -r /opt/jupyterhub /opt/conda /usr/local/share/jupyter/kernels
# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/packages/.recall_functions

# Installing package
## Installscript for miniconda
PathScripts=~/Linux-install-scripts

echo "Part 1: Installing Jupyterhub"
echo ">> INSTALLING DEPENDENCIES"
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get update -qq
sudo apt-get install -qq python3 python3-dev git curl python3-venv nodejs gcc g++ make
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo ln -s /usr/bin/pip3 /usr/bin/pip
echo ">> INSTALLING JUPYTERHUB"
if [[ -d /opt/jupyterhub ]]; then
        echo "It seems Jupyterhub is alreay installed in /opt. Please update from application."
        echo "Skipping download and install"
else
        echo "Installing Jupyterhub"
        sudo python3 -m venv /opt/jupyterhub/
        sudo /opt/jupyterhub/bin/python3 -m pip install -q wheel
        sudo /opt/jupyterhub/bin/python3 -m pip install -q jupyterhub jupyterlab
        sudo /opt/jupyterhub/bin/python3 -m pip install -q -r $PathScripts/requirements.txt
        sudo npm install -g configurable-http-proxy
        sudo mkdir -p /opt/jupyterhub/etc/jupyterhub/
        cd /opt/jupyterhub/etc/jupyterhub/
        sudo /opt/jupyterhub/bin/jupyterhub --generate-config
        sudo sed -i s/"# c.Spawner.default_url = ''"/"c.Spawner.default_url = '\/lab'"/g jupyterhub_config.py

        PathJupServ=/opt/jupyterhub/etc/systemd
        sudo mkdir -p $PathJupServ
        cpfile jupyterhub.service $PathJupServ
        sudo ln -s $PathJupServ/jupyterhub.service /etc/systemd/system/jupyterhub.service
        sudo systemctl daemon-reload
        sudo systemctl enable jupyterhub.service
        sudo systemctl start jupyterhub.service
        #sudo systemctl status jupyterhub.service
        #sudo systemctl stop jupyterhub.service

        #cd /opt/jupyterhub
        #wget https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Jupyter_logo.svg/1200px-Jupyter_logo.svg.png
        cpfile jupyterhub.desktop /usr/share/applications
        sudo chown -R $USER /opt/jupyterhub
        sudo mkdir -p /usr/local/share/jupyter/kernels
        sudo chown -R $USER /usr/local/share/jupyter/kernels
        # #2
        echo "Jupyterhub is installed"
fi

echo "Part 2: Installing conda for the whole system"
# check if app already is installed
if [[ -d /opt/conda ]]; then
        echo "It seems (mini/ana)conda is alreay installed in /opt. Please update from application."
        echo "Skipping download and install"
else
        read -p "Install Anaconda of Miniconda? (miniconda is deafault) [anaconda/miniconda] " am
        if [[ $am != "anaconda" ]]; then
                echo "Installling miniconda3"
                echo "NB choose install location /opt/conda" #7 #8
                get https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
                echo "Miniconda is geinstalleerd"     
        else
                echo "Installling Anaconda"
                curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
                sudo install -o root -g root -m 644 conda.gpg /etc/apt/trusted.gpg.d/
                echo "deb [arch=amd64] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee /etc/apt/sources.list.d/conda.list
                rm conda.gpg
                sudo apt-get update -q
                sudo apt-get install -qq conda
                sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
                echo "Anaconda is geinstalleerd"     
        fi
fi

sudo chown -R $USER /opt/conda
mkdir /opt/conda/envs/
ls -hal /opt/conda/envs
/opt/conda/bin/conda config --add channels conda-forge
/opt/conda/bin/conda init # add init to .bashrc for user
sudo /opt/conda/bin/conda init # add init to .bashrc for root

echo "Conda is installed"
echo "Restarting Jupyterhub"
sudo systemctl restart jupyterhub.service

read -p "Do you want to install extensions en languageservers for Jupyterlab? [y/n] " e
if [ $e != "y" ]; then
        echo "Skipping extending Jupyterlab"
else
        source $PREFIX_/packages/extend_jupyter.sh
        echo "Jupyterlab extended"
fi