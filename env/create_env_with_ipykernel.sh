#! /bin/bash
# define finctions
what_packages() {
    read -p "What packages need to be installed on creation? [space seperated list; leave empty for None] " extra_packages
}
# set variables
[[ $(which conda) != "" ]] && conda=true
[[ $OS == "NAS" ]] && NAS=true

# Installing environmentcd ..
if [[ -f ./environment.yml ]]; then
    envName=$(awk '/name/ {print $2}' ./environment.yml)
    echo "Environment named '$envName' will be installed"
    conda env create -f ./environment.yml -q
else
    read -p "What is the name for the enviroment? " envName
    if [[ $conda ]]; then
        read -p "Are there any other options for conda create? [leave empty for None] " options
        read -p "What location should the environment be installed? [leave empty for defaul] " envLoc
        [[ $envLoc != "" ]] && envLoc="-p "$envLoc
        conda create -n $envName $envLoc pip ipykernel pandas matplotlib plotly -y -q
        source ~/miniconda3/bin/activate $envName
        conda config --add channels conda-forge
        if [[ -f ./requirements.txt ]]; then
            pip install -r requirements.txt -q
        else
            what_packages
            packages="ipykernel $extra_packages"
        fi
        conda deactivate
    else
        [[ $NAS ]] && nopip=--without-pip
        python3 -m venv venv $nopip
        source ./venv/bin/activate
        [[ $NAS ]] && curl -k https://bootstrap.pypa.io/get-pip.py | python
        if [[ -f ./requirements.txt ]]; then
            python -m pip install -r requirements.txt
        else
            what_packages
            python -m pip install $extra_packages
        fi
        [[ $NAS ]] || python -m pip install ipykernel
        deactivate
    fi
fi

# Installing kernel if not NAS
if [[ $OS != "NAS" ]]; then
    if [[ $conda ]]; then
        ~/miniconda3/envs/$envName/bin/python -m ipykernel install --name $envName --display-name $envName
    else
        ./venv/bin/python -m ipykernel install --name $envName --display-name $envName
    fi
fi
