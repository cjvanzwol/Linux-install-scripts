#! /bin/sh 
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
    jupyterlab-execute-time \
    @krassowski/jupyterlab_go_to_definition \
    @jupyterlab/google-drive \
    @jupyterlab/toc \
    @lckr/jupyterlab_variableinspector \
    jupyterlab-topbar-extension jupyterlab-system-monitor jupyterlab-theme-toggle \
    @ijmbarr/jupyterlab_spellchecker \
    @jupyter-voila/jupyterlab-preview
echo ">> CUnstimozing settings"
PathSettingsNb=~/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/
mkdir -p $PathSettingsNb
cp ~/Linux-install-scripts/assets/tracker.jupyterlab-settings $PathSettingsNb

jupyterlab-execute-time: https://github.com/deshaw/jupyterlab-execute-time"

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

<< COMMENT
read -p "Install ...? [y/N]" 
if [[ $ == "y" ]]; then
    sudo /opt/jupyterhub/bin/python3 -m pip install -y 
fi
COMMENT

echo "BUILDING JUPYTER LAB"
jupyter lab build --dev-build=False --minimize=False
deactivate
sudo systemctl restart jupyterhub