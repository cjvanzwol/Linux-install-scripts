#! /bin/bash
# Installscript for anaconda/miniconda.

#CONDA_ROOT=/opt/conda
CONDA_ROOT=/home/$USER/miniconda3
CONDA_BIN=$CONDA_ROOT/bin
# preload functions
source $(find ~ -name Linux-install-scripts 2>/dev/null)/functions.sh
[[ $FASE == "" ]] && FASE=conda

# check if app already is installed
if [[ -d $CONDA_ROOT ]]; then
    echo "It seems (mini/ana)conda is alreay installed in /opt. Please update from application."
    echo "Skipping download and install"
else
    subtitle "Installing conda"
    read -p "Install Anaconda of Miniconda? (miniconda is deafault) [anaconda/miniconda] " am
    if [[ $am != "anaconda" ]]; then
        subsubtitle "Installling miniconda3"
        echo "NB choose install location $CONDA_ROOT" #7 #8
        cd ~
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
        bash Miniconda3-latest-Linux-x86_64.sh
        # edit install script with sed to not prompt for values, but my values are pre inputted
        #sed -i s/.../.../g ~/.jupyter/jupyterlab_config.py
        rm Miniconda3-latest-Linux-x86_64.sh
        echo "Miniconda is installed"
    else
        subsubtitle "Installling anaconda"
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

if [[ -d $CONDA_ROOT ]]; then
	sudo chown -R $USER /opt/conda
	mkdir $CONDA_ROOT/envs/
	ls -hal $CONDA_ROOT/envs
	$CONDA_BIN/conda config --add channels conda-forge
	#conda init # add init to .bashrc for user
	$CONDA_BIN/conda init # add init to .bashrc for root
	$CONDA_BIN/conda install -y nodejs">=15"
	$CONDA_BIN/conda update -y --all
fi
echo "Conda is installed"
