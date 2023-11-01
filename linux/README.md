# StarCitizenFrenchTranslation

Ici, vous trouverez les scripts d'installations pour ceux qui jouent sous Linux en utilisant Lutris.

Avant d'utiliser la version graphique, vous devez installer les dépendances sur votre distribution.

## Installation des dépendances pour la version graphique

### Pour ArchLinux/Manjaro

> pacman -S python-pyqt6

### Pour Debian/Ubuntu/Linux Mint

> apt-get install python3-pyqt6

### Pour Fedora

> dnf install python3-qt6

### Pour Gentoo

> emerge dev-python/PyQt6

### Pour OpenSuse

#### OpenSuse Tumbleweed

> zypper install python-PyQt6
 
### Pour les autres distributions
 
Vous devez installer pip et qt6 sur votre distribution

Vous lancerez ensuite cette commande

> python3 -m pip install PyQt6

## Utilisation

Quel que soit la version que vous souhaiter éxecuter, vérifiez au cas où que le fichier que vous souhaitez éxecuter est éxecutable.

### Version graphique

Pour lancer la version graphique, vous devez lancer le script lutris_gui.sh

### Version ligne de commande

Pour lancer la version ligne de commande, vous devez lancer cette commande dans un terminal dans le dossier où se trouve le script.

> ./lutris_console.sh