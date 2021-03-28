#! /bin/sh
## Installscript for Jupyterlab

# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=jupyterlab

subtitle "Installing Jupyterlab"
subsubtitle ">> INSTALLING DEPENDENCIES"
install --dep $1 conda java
subsubtitle ">> INSTALLING JUPYTERLAB"

echo $CONDA_ROOT
CONDA_BIN="$CONDA_ROOT/bin"

$CONDA_BIN/conda install -y jupyterlab">=3" jupyterlab-git ipywidgets pandas matplotlib ipympl
$CONDA_BIN/jupyter lab --generate-config
$CONDA_BIN/jupyter lab password

cpfile jupyterlab.service /etc/systemd/system
sudo sed -i s_"USER"_"$USER"_g /etc/systemd/system/jupyterlab.service
sudo systemctl daemon-reload
sudo systemctl enable jupyterlab.service

mkdir -p ~.local/share/jupyter/kernels
# sudo mkdir -p /usr/local/share/jupyter/kernels
# sudo chown -R $USER /usr/local/share/jupyter/kernels

cpfile jupyterlab /usr/bin 

echo "Jupyterlab is installed"
# #2

echo "Cloning my notebook repo's"
git clone https://github.com/cjvanzwol/notebooks.git ~
git clone https://github.com/cjvanzwol/Risk-Machine-Learning.git ~

read -p "Do you want to install extensions en languageservers for Jupyterlab? [y/n] " e
if [ $e != "y" ]; then
        echo "Skipping extending Jupyterlab"
else
        source ./Linux-install-scripts/extend_jupyter.sh
        echo "Jupyterlab extended"
fi