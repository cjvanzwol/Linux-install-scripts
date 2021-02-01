#! /bin/sh
if [[ $functionsSet != True ]]; then
    PREFIX_=$(find / -name Linux-install-scripts 2>/dev/null)

    ######################
    # defining functions #
    ######################
    title() { echo "------------------"; echo $1; }
    subtitle() { echo; echo ">> $1"; }
    subsubtitle() { echo; echo ">>>> $1"; }
    
    dev() {
        [[ $1 == "--dev" ]] && read -p "PAUZING FOR DEBUGGING"
    }

    cpfile() {
        mkdir -p $2 || local RETRY_MKDIR=true
        [[ $RETRY_MKDIR ]] && echo "Retrying with sudo" && sudo mkdir -p $2 && echo "sudo worked, continuing"
        #echo $1
        local FILE=$PREFIX_/assets/$FASE/$1
        #echo $FILE
        cp $FILE $2 || local RETRY_CP=true
        [[ $RETRY_CP ]] && echo "Retrying with sudo" && sudo cp $FILE $2 && echo "sudo worked, continuing"
    }

    install() {
    toInstall=()
    for app in $@; do
    if [[ $app == "--dev" ]]; then
        :
    elif [[ $app == "--dep" ]]; then
        local DEP=true
    else
        if [[ $(which $app) == "" ]]; then
            if [[ $DEP == true ]]; then
                toInstall+=( $app )
            else    
                read -p "Do you want to install $app [y/n] " a
                if [[ $a == "y" ]]; then
                    toInstall+=( $app )
                fi
            fi
        else
            echo "$app is already installed"
        fi
    fi
    done
    for app in "${toInstall[@]}"; do
        local FASE_TMP=$FASE
        FASE=$app
        source $PREFIX_/packages/install_$app.sh
        [[ $DEP == true ]] && FASE=$FASE_TMP
        dev $1
    done
    }

    get() {
    [[ $(which wget) != "" ]] && sudo apt-get update -q && sudo apt-get install -qq wget
    if [[ $1 == *deb ]]; then
        wget -q -O ~/i.deb $1
        sudo apt-get install ./i.deb
        rm i.deb
    elif [[ $1 == *sh ]]; then
        wget -q -O ~/i.sh $1
        sudo bash ~/i.sh
        rm ~/i.sh
    else
        read -p "GET ERROR: filetype could nog be recovered. package is nog installed. CONTINUE?"
    fi
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
