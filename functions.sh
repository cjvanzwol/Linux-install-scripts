#! /bin/sh
if [[ $functionsSet != True ]]; then
    PREFIX_=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )

    # functions
    title() { echo "------------------"; echo $1; }
    subtitle() { echo; echo ">> $1"; }
    subsubtitle() { echo; echo ">>>> $1"; }
    cpfile() {
        mkdir -p $2 || echo "retrying with sudo" && sudo mkdir -p $2 && echo "it worked! continuing now"
        local FILE=$PREFIX_/assets/$FASE/$1
    }

    install() {
    toInstall=()
    for app in $@; do
        read -p "Do you want to install $app [y/n] " a
        if [[ $a == "y" ]]; then
        toInstall+=( $app )
        fi
    done

    for app in "${toInstall[@]}"; do
        FASE=$app
        echo $FASE
        source $PREFIX_/packages/install_$app.sh
    done
    }
    get() {
    wget -q -O i.deb $1
            sudo apt-get install ./i.deb
            rm i.deb
    }

    functionsSet=True
    echo "done"
fi

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
