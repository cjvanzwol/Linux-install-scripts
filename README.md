# lis = Linux install scripts
Scripts for (re)installing personal setup for Linux

## Usage
After installing new (virtual) machine, run the following:
```bash
git clone ...
bash Linux-install-scripts/setup.sh
```

## What does this script
## Base
1. update system
2. Installing minimal packages:
 - [nano](https://nano-editor.org/)
 - [git](https://git-scm.com/)
 - [mesa-utils](https://mesa3d.org/)
 - [TheFuck](https://github.com/nvbn/thefuck)

## ChomeOS - Crostini
After installing Crostini no password is set for the user and root. So `sudo` doesn't work. On first instal before running any scripts open the crosh-terminal with Crtl+Alt+t. Then run:
```shell
vsh termina
lxc exec penguin -- bash
passwd
sudo passwd
```

### Packages available in setup
- Jupyterhub, for Jupyterlab with extensions
> Alternatives: [Deepnote](https://deepnote.com/project/6aa43c31-e561-4258-b958-6792614774f6#%2Fnotebooks%2FCovid%2FCovid.ipynb), [Google Colab](https://colab.research.google.com/)
- [miniconda3](https://docs.conda.io/en/latest/miniconda.html)
- [Codile](https://github.com/dimkr/codile)
> Alternatives:
> - [VScode](https://code.visualstudio.com/) (too slow)
> - [VSCodium](https://vscodium.com/) (slow)
> - [code-server](https://github.com/cdr/code-server) (stutters)
> - [Github Codespaces](https://github.com/features/codespaces) (works fine, but wil be paid)
> - [Gitpod](https://www.gitpod.io/) (too slow)
> - [Eclispe Che](https://www.eclipse.org/che/)
- [Gimp](https://www.gimp.org/)
- [Inkscape](https://inkscape.org/)
- [Firefox](https://www.mozilla.org/nl/firefox/)
- [google-chrome](https://www.google.com/intl/nl_nl/chrome/)

~~~
Work in progress
(auto)backup
- [syncthing](https://syncthing.net/)
~~~


## Raspberri Pi OS (Lite, I use Raspberry Pi 2)
contains:
- [samba](https://pimylifeup.com/raspberry-pi-samba/)
- [Jupyter](https://github.com/kleinee/jns)
- [nfs client](https://www.htpcguides.com/configure-nfs-server-and-nfs-client-raspberry-pi/)

## Synology NAS DS216play
contains:
- nothing yet

## other devices or distros
contains:
- nothing yet
