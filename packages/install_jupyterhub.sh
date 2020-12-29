#! /bin/sh
# DEBUG
#sudo rm /usr/bin/python /usr/bin/pip /etc/systemd/system/jupyterhub.service /usr/share/applications/jupyterhub.desktop /etc/profile.d/conda.sh
#sudo rm -r /opt/jupyterhub /opt/conda /usr/local/share/jupyter/kernels

# preload functions
source $( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )/.recall_functions

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
        # Installing package
        source /opt/jupyterhub/bin/activate

        echo "KERNELS"
        echo "Installing bash_kernel"
        sudo /opt/jupyterhub/bin/python3 -m pip install -q bash_kernel
        sudo /opt/jupyterhub/bin/python3 -m bash_kernel.install

        # #4
        # read -p "Install Javascript? [y/N]" js 
        # if [[ $js == "y" ]]; then
        #     sudo npm install -g --unsafe-perm ijavascript
        #     sudo ijsinstall --install=global
        #fi

        # #5
        # read -p "Install Nodejs? [y/N]" nj 
        # if [[ $nj == "y" ]]; then
        #     source /opt/jupyterhub/bin/activate
        #     cd sudo ~
        #     sudo git clone https://github.com/notablemind/jupyter-nodejs.git
        #     sudo cd jupyter-nodejs
        #     sudo mkdir -p ~/.ipython/kernels/nodejs/
        #     sudo npm install && sudo node install.js
        #     sudo npm run build
        #     sudo npm run build-ext
        #     sudo jupyter console --kernel nodejs
        # fi

        echo "EXTENSIONS"
        echo ">> installing"
        sudo /opt/jupyterhub/bin/python3 -m pip install -q voila
        jupyter labextension install -y --no-build \
        @jupyter-widgets/jupyterlab-manager \
        @krassowski/jupyterlab_go_to_definition \
        @jupyterlab/toc \
        @lckr/jupyterlab_variableinspector \
        jupyterlab-topbar-extension jupyterlab-system-monitor jupyterlab-theme-toggle \

        # gave error
        read -p "trying te install which gave error"
        jupyter labextension install -y --no-build jupyterlab-execute-time # jupyterlab-execute-time: https://github.com/deshaw/jupyterlab-execute-time"
        jupyter labextension install -y --no-build @jupyterlab/google-drive
        jupyter labextension install -y --no-build @ijmbarr/jupyterlab_spellchecker
        jupyter labextension install -y --no-build f@jupyter-voila/jupyterlab-preview
        echo ">> CUnstimozing settings"
        cpfile tracker.jupyterlab-settings ~/.jupyter/lab/user-settings/@jupyterlab/notebook-extension

        read -p "Install Language server? [y/N]" ls
        if [[ $ls == "y" ]]; then
        sudo /opt/jupyterhub/bin/python3 -m pip install -q jupyter-lsp 
        jupyter labextension install --no-build @krassowski/jupyterlab-lsp 
        sudo /opt/jupyterhub/bin/python3 -m pip install -q python-language-server[all]
        sudo npm install --save-dev -y \
                bash-language-server \
                javascript-typescript-langserver \
                unified-language-server \
                vscode-css-languageserver-bin \
                vscode-html-languageserver-bin \
                vscode-json-languageserver-bin
        fi
        read -p "Install Code Formatter? [y/N]" cf
        if [[ $cf == "y" ]]; then
        sudo /opt/jupyterhub/bin/python3 -m pip install -q jupyterlab-code-formatter 
        jupyter labextension install -y --no-build @ryantam626/jupyterlab_code_formatter
        sudo /opt/jupyterhub/bin/python3 -m pip install -q autopep8 #black yapf isort
        sudo /opt/jupyterhub/bin/jupyter serverextension enable --py jupyterlab_code_formatter
        fi
        read -p "Install Debugger? [y/N]" db
        if [[ $db == "y" ]]; then
        sudo /opt/jupyterhub/bin/python3 -m pip install -q ptvsd #xeus-python #10
        jupyter labextension install --no-build @jupyterlab/debugger
        fi

        echo "THEMES"
        echo "dracula"
        jupyter labextension install --no-build @telamonian/theme-darcula -y

        echo "BUILDING JUPYTER LAB"
        jupyter lab build --dev-build=False --minimize=False
        deactivate
        sudo systemctl restart jupyterhub

        echo "Jupyterlab extended"
fi