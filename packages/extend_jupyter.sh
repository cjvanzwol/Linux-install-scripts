#! /bin/sh
CONDA_BIN=/opt/conda/bin
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh

#subtitel "KERNELS"
#subsubtitle "Installing bash_kernel"
#$CONDA_BIN/conda install -q bash_kernel
#$CONDA_BIN/python -m bash_kernel.install

subtitel "EXTENSIONS"
subsubtitle ">> installing"
$CONDA_BIN/jupyter labextension install -y --no-build \
    @jupyter-widgets/jupyterlab-manager \
    @lckr/jupyterlab_variableinspector

dev $1
$CONDA_BIN/conda install -q voila
$CONDA_BIN/jupyter labextension install -y --no-build \
    jupyterlab-execute-time \ #https://github.com/deshaw/jupyterlab-execute-time"
    @krassowski/jupyterlab_go_to_definition \
    @jupyterlab/google-drive \
    @jupyterlab/toc \
    jupyterlab-topbar-extension jupyterlab-system-monitor jupyterlab-theme-toggle \
    @ijmbarr/jupyterlab_spellchecker \
    @jupyter-voila/jupyterlab-preview
dev $1
subsubtitle ">> CUnstimozing settings"
PathSettingsNb=~/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/
mkdir -p $PathSettingsNb
cp ~/Linux-install-scripts/assets/tracker.jupyterlab-settings $PathSettingsNb



dev $1
read -p "Install Language server? [y/N]" ls
if [[ $ls == "y" ]]; then
    $CONDA_BIN/conda install -q jupyter-lsp 
    $CONDA_BIN/jupyter labextension install --no-build @krassowski/jupyterlab-lsp 
    $CONDA_BIN/conda install -q python-language-server[all]
    sudo npm install --save-dev -y \
        bash-language-server \
        javascript-typescript-langserver \
        unified-language-server \
        vscode-css-languageserver-bin \
        vscode-html-languageserver-bin \
        vscode-json-languageserver-bin
fi

dev $1
read -p "Install Code Formatter? [y/N]" cf
if [[ $cf == "y" ]]; then
    $CONDA_BIN/conda install -q jupyterlab-code-formatter 
    $CONDA_BIN/jupyter labextension install -y --no-build @ryantam626/jupyterlab_code_formatter
    $CONDA_BIN/conda install -q autopep8 #black yapf isort
    $CONDA_BIN/jupyter serverextension enable --py jupyterlab_code_formatter
fi
read -p "Install Debugger? [y/N]" db
if [[ $db == "y" ]]; then
    $CONDA_BIN/conda install -q ptvsd xeus-python #10
    $CONDA_BIN/jupyter labextension install --no-build @jupyterlab/debugger
fi

dev $1
echo "THEMES"
echo "dracula"
$CONDA_BIN/jupyter labextension install --no-build @telamonian/theme-darcula -y

dev $1
echo "BUILDING JUPYTER LAB"
$CONDA_BIN/jupyter lab build --dev-build=False --minimize=False