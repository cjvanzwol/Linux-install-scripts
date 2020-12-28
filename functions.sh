#! /bin/sh
if [[ $functionsSet != True ]]; then
  ######################
  # defining functions #
  ######################
  title() { echo "------------------"; echo $1; }
  subtitle() { echo; echo ">> $1"; }
  subsubtitle() { echo; echo ">>>> $1"; }
  cpfile() {
    ls -hal $2
    mkdir -p $2 || echo "Retrying with sudo" && sudo mkdir -p $2 && echo "sudo worked, continuing"
    ls -hal $2
    read -p "debug3"
    local FILE=$PREFIX_/assets/$FASE/$1
    echo $FILE
    read -p "debug2"
    cp $FILE $2 || echo "Retrying with sudo" && sudo cp $FILE $2 && echo "sudo worked, continuing"
    ls -hal $2
    read -p "debug1"
  }

  install() {
  toInstall=()
  for app in $@; do
    if [[ $(which $app) == "" ]]; then
      read -p "Do you want to install $app [y/n] " a
      if [[ $a == "y" ]]; then
        toInstall+=( $app )
      fi
    else
      echo "$app is already installed"
    fi
  done
  for app in "${toInstall[@]}"; do
      FASE=$app
      source $PREFIX_/packages/install_$app.sh
      read -p "INSTALLING ONE PACKAGE DONE: PAUZING FOR DEBUG"
  done
  }

  get() {
    wget -q -O i.deb $1
    sudo apt-get install ./i.deb
    rm i.deb
  }

  functionsSet=True
  echo "functions are defined"

  #############################
  # check which OS is running #
  #############################
  case $(uname -n) in
    penguin)
      OS="ChromeOS"
      ;;
    osmc)
      OS="OSMC"
      ;;
    synology_monaco_ds216play | nas)
      OS="NAS"
      ;;
    *)
      OS="other OS"
      ;;
  esac
  echo "OS is set as install variable"
fi
