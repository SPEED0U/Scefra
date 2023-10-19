# StarCitizenFrenchTranslation
Ceci est un repository où vous pouvez trouver la traduction Française pour Star Citizen.
La base de la traduction (Anglais vers Français) a été générée par l'API de Google Traduction et est corrigée par des contributeus.

Lien de notre serveur Discord: https://discord.gg/c3CSTa7SAF

**Table des matières :**
1. [Installation automatique (RECOMMANDÉ)](#installation-automatique)
2. [Installation manuelle](#installation-manuelr)


### Installation automatique
> - Télécharger le script Powershell [ici](https://cdn.discordapp.com/attachments/954001140519944193/1164243159832870994/install_fr.ps1?ex=654280ef&is=65300bef&hm=d363981e3a164e0aa092f3db9adab6f9fd93d9a092bc8ca5a1f24dd37b0f1cb8&).
> - Placer le fichier `install_fr.ps1` dans le dossier `C:\PATH\TO\GAME\Robert Space Industries\StarCitizen`.
> - Exécuter le fichier `install_fr.ps1` avec  l'application Windows `Powershell` ou double-cliquez sur le fichier ou clique droit sur le fichier et sélectionnez `Exécuter avec Powershell`.
> - Suivez les instructions sur l'écran du Powershell.
>
> ⚠️ - **Avec cette méthode, vous avez juste à ré-exécuter le fichier `install_fr.ps1` afin de mettre à jour automatiquement le fichier de traduction.**

### Installation manuelle
> - Télécharger les fichiers du répertoire avec le bouton vert `Code` en haut à droite.
> - Extraire le language désiré dans le dossier `C:\PATH\TO\GAME\Robert Space Industries\StarCitizen\LIVE\data\Localization`
> - Créer un fichier `user.cfg` (activé les extensions des fichiers dans les paramètres de Windows) dans le dossier `C:\PATH\TO\GAME\Robert Space Industries\StarCitizen\LIVE` si vous en avez pas déjà un.
> - Dans le fichier `user.cfg` ajouter une ligne `g_language=` puis ajouter le language désiré après le `=`, exemple : `g_language=french_(france)`
> - Enregistrer le fichier puis vous pourrez démarrer le jeu.
>
> ⚠️ - **Avec cette méthode il se peut que la traduction ne fonctionne pas, pour résoudre le soucis il faut réencoder le fichier `global.ini` en `UTF8 with BOM` avec un logiciel type Notepad++.**


### Comment contribuer ?
Vous pouvez contribuer à la correction de la traduction en vous inscrivant au site ci-dessous.
- Lien: https://tradsc.nightriderz.world/fr/scfr/

### Problèmes connus
- Les lettres avec des accents comme "é","à","ö" etc. soit n'apparaissent pas ou elles sont affichées en minuscule.

