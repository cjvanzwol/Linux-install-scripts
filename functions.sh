#! /bin/bash
#echo "loading functions"
if [[ $functionsSet != True ]]; then
    #PREFIX_=$(find ~ -name lis 2>/dev/null)
    PREFIX_=~/lis

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
    [[ $(which wget) != "" ]] || echo "installing wget" && sudo apt-get update -qq && sudo apt-get -qq install wget
    WGET_TEMP=~/.wget_temp
    mkdir $WGET_TEMP
    wget -q --show-progress -P $WGET_TEMP --content-disposition $1 #OLD CODE: wget -q -O $WGET_TEMP/i.deb $1
    DL=$(ls $WGET_TEMP)
    if [[ $DL == *.deb ]]; then
        sudo apt-get install -qq $WGET_TEMP/*.deb
    elif [[ $DL == *.sh ]]; then
        sudo bash $WGET_TEMP/*.deb
    elif [[ $DL == *tar.gz ]]; then
        touch $2/.permission_granted && rm $2/.permission_granted || local RETRY_TAR=true
        [[ $RETRY_TAR ]] || tar -xzf $WGET_TEMP/$DL -C $2
        [[ $RETRY_TAR ]] && echo "Retrying with sudo" && sudo tar -xzf $WGET_TEMP/$DL -C $2 && sudo chown root:root -R /opt/Postman && echo "sudo worked, continuing"
    else
        echo "GET ERROR: filetype could not be recovered. package is downloaded but not installed."
        ls -l $WGET_TEMP
        read -p "CONTINUE?"
    fi
    sudo rm -r $WGET_TEMP
    }

#   cloneRepo() {
#     xdg-open "https://github.com/$ghu?tab=repositories"
#     read -p "Name of repo to clone: " repo
#     if [[ -f $(/home/linuxbrew/.linuxbrew/bin/gh) ]]; then
#         /home/linuxbrew/.linuxbrew/bin/gh repo clone $repo ~
#     else
#         git clone $repo
#     fi
#   }

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
    synology* | nas | Nas)
        OS="NAS"
        ;;
    cs-15730755499-default-boost*)
        OS="GoogleShell"
        ;;
    *)
        OS="other OS"
        uname -a
        ;;
    esac
    title "Setting up Linux for $OS"
fi
