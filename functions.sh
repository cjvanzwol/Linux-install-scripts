#! /bin/sh
if [[ $functionsSet != True ]]; then
  ######################
  # defining functions #
  ######################
  title() { echo "------------------"; echo $1; }
  subtitle() { echo; echo ">> $1"; }
  subsubtitle() { echo; echo ">>>> $1"; }
  cpfile() {
    mkdir -p $2 || sudo mkdir -p $2
    local FILE=$PREFIX_/assets/$FASE/$1
    cp $FILE $2 || sudo cp $FILE $2
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
