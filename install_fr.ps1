set-executionpolicy unrestricted

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$localization1 = Join-Path $ScriptDir "LIVE"
$localization2 = Join-Path $ScriptDir "PTU"

# Fonction pour afficher le texte art ASCII
function Show-ASCII-Art {
    Write-Host @"
                           *     .--.
                                / /  `
               +               | |
                      '         \ \__,
                  *          +   '--'  *
                      +   /\
         +              .'  '.   *
                *      /======\      +
                      ;:.  _   ;
                      |:. (_)  |
                      |:.  _   |
            +         |:. (_)  |          *
                      ;:.      ;
                    .' \:.    / `.
                   / .-'':._.'`-. \
                   |/    /||\    \|
             jgs _..--"""````"""--.._
           _.-'``                    ``'-._
         -'                                '-

Contributeur:
-SPEEDOU
-Xety
-viviengraffin
-CNV_301/BOB
"@
}

function Show-Menu {
    Clear-Host
    Show-ASCII-Art
    Write-Host "Menu :"
    Write-Host "1. Traduire la version Live"
    Write-Host "2. Traduire la version PTU"
    Write-Host "3. Recuperer le fichier de traductions depuis Internet"
    Write-Host "4. Participer a la traduction"
    Write-Host "5. Créer un raccourci"
    Write-Host "6. Quitter"
}

function Create-Shortcut {
    # Crée un raccourci vers le script PowerShell sur le bureau
    $desktopPath = [System.Environment]::GetFolderPath('Desktop')
    $shortcutFile = Join-Path $desktopPath "StarCitizen - Translation FR.ps1.lnk"
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutFile)
    $shortcut.TargetPath = $PSCommandPath
    $shortcut.WorkingDirectory = $ScriptDir  # Spécifiez le répertoire de travail ici
    $shortcut.Save()
    Write-Host "Raccourci créé sur le bureau : $shortcutFile"
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        '1' {
            Clear-Host
            Write-Host "Traduction du Live."

            # Vérification de la présence du Live
            Write-Host "Vérification de la présence du Live"
            if (-not (Test-Path -Path $localization1 -PathType Container)) {
                Write-Host "Je ne trouve pas le Live. Veuillez vérifier que vous m'avez placé dans le répertoire StarCitizen."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
            else {
                # Création du fichier user.cfg dans le live
                Write-Host "Création du fichier user.cfg dans le live"
                Set-Content -Path "$localization1\user.cfg" -Value 'g_language = french_(france)'
                Add-Content -Path "$localization1\user.cfg" -Value 'g_languageAudio = english'

                # Création des répertoires nécessaires dans le live"
                Write-Host "Création des répertoires nécessaires dans le live"
                $liveLocalizationDir = Join-Path $localization1 "data\Localization\french_(france)"
                if (-not (Test-Path -Path $liveLocalizationDir -PathType Container)) {
                    New-Item -Path $liveLocalizationDir -ItemType Directory -Force
                }

                # Téléchargement et copie du fichier de traduction dans le live
                Write-Host "Téléchargement et copie du fichier de traduction dans le live"
                $url = "https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini"
                $outputPath = Join-Path $liveLocalizationDir "global.ini"

                # Télécharge le contenu du fichier
                $response = Invoke-WebRequest -Uri $url

                # Assurez-vous que le contenu est en UTF-8 avec BOM et CRLF
                $utf8Encoding = New-Object System.Text.UTF8Encoding $true
                [System.IO.File]::WriteAllText($outputPath, $response.Content, $utf8Encoding)

                Write-Host "Installation du dernier fichier de traduction dans le live, terminé."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
        }
        '2' {
            Clear-Host
            Write-Host "Traduction du PTU"
            # Vérification de la présence du PTU
            Write-Host "Vérification de la présence du PTU"

            if (-not (Test-Path -Path $localization2 -PathType Container)) {
                Write-Host "Je ne trouve pas la version PTU. Veuillez vérifier que vous m'avez placé dans le répertoire StarCitizen."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
            else {
                # Création du fichier user.cfg dans le ptu
                Set-Content -Path "$localization2\user.cfg" -Value 'g_language = french_(france)'
                Add-Content -Path "$localization2\user.cfg" -Value 'g_languageAudio = english'

                # Création des répertoires nécessaires dans le ptu
                Write-Host "Création des répertoires nécessaires dans le PTU"
                $ptuLocalizationDir = Join-Path $localization2 "data\Localization\french_(france)"
                if (-not (Test-Path -Path $ptuLocalizationDir -PathType Container)) {
                    New-Item -Path $ptuLocalizationDir -ItemType Directory -Force
                }

                # Téléchargement et copie du fichier de traduction dans le PTU
                Write-Host "Téléchargement et copie du fichier de traduction dans le PTU"
                $url = "https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini"
                $outputPath = Join-Path $ptuLocalizationDir "global.ini"

                # Télécharge le contenu du fichier
                $response = Invoke-WebRequest -Uri $url

                # Assurez-vous que le contenu est en UTF-8 avec BOM et CRLF
                $utf8Encoding = New-Object System.Text.UTF8Encoding $true
                [System.IO.File]::WriteAllText($outputPath, $response.Content, $utf8Encoding)

                Write-Host "Installation du dernier fichier de traduction dans le PTU, terminé."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
        }
        '3' {
            Clear-Host
            Write-Host "Vous avez choisi l'option 3."
        
            # Téléchargement du fichier de traduction depuis Internet
            $url = "https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini"
            $outputPath = Join-Path $ScriptDir "global.ini"
        
            # Télécharge le contenu du fichier
            $response = Invoke-WebRequest -Uri $url
        
            # Crée un StreamWriter avec l'encodage UTF-8 et BOM pour écrire le fichier
            $utf8EncodingWithBOM = New-Object System.Text.UTF8Encoding $true
            $writer = [System.IO.StreamWriter]::new($outputPath, $false, $utf8EncodingWithBOM)
        
            # Écrit le contenu dans le fichier
            $writer.Write($response.Content)
        
            # Ferme le StreamWriter
            $writer.Close()
        
            Write-Host "Récupération du dernier fichier de traduction."
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
        '4' {
            Clear-Host
            Write-Host "Ouverture de la page internet"
            Start-Process "https://tradsc.nightriderz.world/fr/"
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
        '5' {
            Clear-Host
            Write-Host "Création du raccourci sur le bureau : $shortcutFile"
            Create-Shortcut
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
        '6' {
            exit
        }
        default {
            Clear-Host
            Write-Host "Choix invalide. Veuillez choisir une option valide."
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
    }
}
