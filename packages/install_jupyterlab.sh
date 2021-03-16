#! /bin/sh
## Installscript for Jupyterlab

# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=jupyterlab

subtitle "Installing Jupyterlab"
subsubtitle ">> INSTALLING DEPENDENCIES"
install --dep $1 conda java
subsubtitle ">> INSTALLING JUPYTERLAB"

/opt/conda/bin/conda install -y jupyterlab">=3" jupyterlab-git ipywidgets pandas matplotlib ipympl
/opt/conda/bin/jupyter lab --generate-config
/opt/conda/bin/jupyter lab password

cpfile jupyterlab.service /etc/systemd/system
sudo sed -i s/User=/User=$USER/g /etc/systemd/system/jupyterlab.service
sudo systemctl daemon-reload

cpfile cli.sh /usr/share/jupyterlab
cpfile jupyterlab.desktop /usr/share/applications
py_path=$(python -c "import sys; print(sys.path)" | cut -d " " -f 5 | cut -d "'" -f 2)
#wget https://raw.githubusercontent.com/jupyter/notebook/master/notebook/static/favicon.ico
sudo sed -i s_Icon=_Icon=$py_path\/notebook\/static\/favicon.ico_g /usr/share/applications/jupyterlab.desktop
sudo mkdir -p /usr/local/share/jupyter/kernels
sudo chown -R $USER /usr/local/share/jupyter/kernels
cpfile jupyterlab /usr/bin 
echo "Jupyterlab is installed"
# #2

read -p "Do you want to install extensions en languageservers for Jupyterlab? [y/n] " e
if [ $e != "y" ]; then
        echo "Skipping extending Jupyterlab"
else
        source ./Linux-install-scripts/extend_jupyter.sh
        echo "Jupyterlab extended"
fi