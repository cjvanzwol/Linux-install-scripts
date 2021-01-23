#! /bin/sh
## Installscript for Jupyterlab

# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/packages/.recall_functions

# Installing dependencies

echo "Installing Jupyterlab"
echo ">> INSTALLING DEPENDENCIES"
install conda
echo ">> INSTALLING JUPYTERHUB"
conda activate base
conda install jupyterlab jupyterlab-git ipywidgets pandas matplotlib ipympl
#cd /opt/conda
jupyter lab --generate-config
#sed -i s/"# c.Spawner.default_url = ''"/"c.Spawner.default_url = '\/lab'"/g jupyterhub_config.py
cpfile jupyterlab.service /etc/systemd/system/jupyterlab.service
sudo systemctl daemon-reload
sudo systemctl enable jupyterlab
sudo systemctl start jupyterlab
#sudo systemctl status jupyterhub
#sudo systemctl stop jupyterhub

cpfile jupyterlab.desktop /usr/share/applications/jupyterhub.desktop

sudo mkdir -p /usr/local/share/jupyter/kernels
sudo chown -R $USER /usr/local/share/jupyter/kernels
# #2
echo "Jupyterlab is installed"

read -p "Do you want to install extensions en languageservers for Jupyterlab? [y/n] " e
if [ $e != "y" ]; then
        echo "Skipping extending Jupyterlab"
else
        source ./Linux-install-scripts/extend_jupyter.sh
        echo "Jupyterlab extended"
fi
