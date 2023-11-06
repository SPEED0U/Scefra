# StarCitizenFrenchTranslation

Ici, vous trouverez les scripts d'installations pour ceux qui jouent sous Linux en utilisant Lutris.

Avant d'utiliser l'un de ces scripts, vous devez installer les dépendances sur votre distribution.

## Installation des dépendances

### Pour ArchLinux/Manjaro

#### Version console

> pacman -S python-configobj

#### Version Graphique

> pacman -S python-pyqt6 python-configobj

### Pour Debian/Ubuntu/Linux Mint

#### Version console

> apt-get install python3-configobj

#### Version graphique

> apt-get install python3-pyqt6 python3-configobj

### Pour Fedora

#### Version console

> dnf install python3-configobj

#### Version graphique

> dnf install python3-qt6 python3-configobj

### Pour Gentoo

#### Version console

> emerge dev-python/configobj

#### Version graphique

> emerge dev-python/PyQt6 dev-python/configobj

### Pour OpenSuse

#### OpenSuse Tumbleweed

##### Version console

> zypper install python-configobj

##### Version graphique

> zypper install python-PyQt6 python-configobj
 
### Pour les autres distributions
 
Vous devez installer pip et qt6 sur votre distribution

Vous lancerez ensuite cette commande

> python3 -m pip install PyQt6
> python3 -m pip install configobj

## Utilisation

Quel que soit la version que vous souhaiter éxecuter, vérifiez au cas où que le fichier que vous souhaitez éxecuter est éxecutable.

### Version graphique

Pour lancer la version graphique, vous devez lancer le script lutris_gui.sh

### Version console

Pour lancer la version ligne de commande, vous devez lancer cette commande dans un terminal dans le dossier où se trouve le script.

> ./lutris_console.sh