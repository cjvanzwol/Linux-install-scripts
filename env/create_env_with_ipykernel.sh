#! /bin/sh
# define finctions
what_packages() {
    read -p "What packages need to be installed on creation? [space seperated list; leave empty for None] " extra_packages
}
# set variables
if [[ $(which conda) != "" ]]; then conda=true; else conda=false; fi

# Installing environmentcd ..
if [[ -f ./environment.yml ]]; then
    envName=$(awk '/name/ {print $2}' ./environment.yml)
    echo "Environment named '$envName' will be installed"
    conda env create -f ./environment.yml -q
else
    read -p "What is the name for the enviroment? " envName
    if [[ $(which conda) != "" ]]; then
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
        echo "DO PIP & virtual env --> still needs to be coded"
        ~/miniconda3/bin/python -m venv venv 
        source ./venv/bin/activate
        if [[ -f ./requirements.txt ]]; then
            python -m pip install -r requirements.txt
        else
            what_packages
            python -m pip install $extra_packages
        fi
        python -m pip install ipykernel
        deactivate
    fi
fi

# Installing kernel
if [[ $conda ]]; then
    ~/miniconda3/envs/$envName/bin/python -m ipykernel install --name $envName --display-name $envName
else
    ./venv/bin/python -m ipykernel install --name $envName --display-name $envName
fi