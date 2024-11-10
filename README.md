# Scefra
Ceci est un repository où vous pouvez trouver la traduction Française pour Star Citizen.
La base de la traduction (Anglais vers Français) a été générée par l'API de ChatGPT (4o) et est corrigée par des contributeus.

Lien de notre serveur Discord: https://discord.gg/c3CSTa7SAF

**Table des matières :**
1. [Installation automatique avec l'app SCFR](#installation-automatique)
2. [Installation manuelle](#installation-manuelle)
3. [Contribuer a la correction](#contribuer)

### Installation automatique
- Télécharger l'installeur de l'appli MultiTool [ici](https://www.microsoft.com/store/productId/9MWD1VN65WCN?ocid=pdpshare).
- Executer `Multitool - StarCitizen Toolbox Installer.exe` pour l'installer.
- Une fois installé l'appli va s'ouvrir et vous pourrez la retrouver dans votre menu démarrer.
- Suivez les instructions sur l'appli, allez dans l'onglet traduction et vos installations seront listées ici.

### Installation manuelle
- Télécharger les fichiers du répertoire avec le bouton vert `Code` en haut à droite.
- Extraire le language désiré dans le dossier `C:\PATH\TO\GAME\Robert Space Industries\StarCitizen\LIVE\data\Localization`
- Créer un fichier `user.cfg` (activé les extensions des fichiers dans les paramètres de Windows) dans le dossier `C:\PATH\TO\GAME\Robert Space Industries\StarCitizen\LIVE` si vous en avez pas déjà un.
- Dans le fichier `user.cfg` ajouter une ligne `g_language=` puis ajouter le language désiré après le `=`, exemple : `g_language=french_(france)`
- Enregistrer le fichier puis vous pourrez démarrer le jeu.

:warning: - **Avec cette méthode il se peut que la traduction ne fonctionne pas, pour résoudre le soucis il faut réencoder le fichier `global.ini` en `UTF8 with BOM` avec un logiciel type Notepad++.**

### Contribuer
- Aller sur [pontoon](https://pontoon.scefra.fr) et s'enregistrer.
- Ensuite aller sur [la page du projet](https://pontoon.scefra.fr/fr/scefra/locales/fr/global.ini/).
- Chercher la traduction a corriger via la barre de recherche.
- Soummettre votre suggestion

### Problèmes connus
- Les lettres avec des accents comme `é`,`à`,`ö` etc. soit n'apparaissent pas ou elles sont affichées en minuscule.

Un grand merci à [Onivoid](https://github.com/Skullyfox) pour son travail sur l'appli [MultiTool](https://github.com/Skullyfox/SCFR) !
