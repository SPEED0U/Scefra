$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$localization1 = Join-Path $ScriptDir "LIVE"
$localization2 = Join-Path $ScriptDir "PTU"

function Show-Menu {
    Clear-Host
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
    $shortcut.TargetPath = $MyInvocation.MyCommand.Path
    $shortcut.Save()
    Write-Host "Raccourci créé sur le bureau : $shortcutFile"
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        '1' {
            Write-Host "Vous avez choisi l'option 1."

            if (-not (Test-Path -Path $localization1 -PathType Container)) {
                Write-Host "Je ne trouve pas le Live. Veuillez vérifier que vous m'avez placé dans le répertoire StarCitizen."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
            else {
                # Création du fichier user.cfg dans le live
                Set-Content -Path "$localization1\user.cfg" -Value 'g_language = french_(france)'

                # Création des répertoires nécessaires dans le live
                $liveLocalizationDir = Join-Path $localization1 "data\Localization\french_(france)"
                if (-not (Test-Path -Path $liveLocalizationDir -PathType Container)) {
                    New-Item -Path $liveLocalizationDir -ItemType Directory -Force
                }

                # Téléchargement et copie du fichier de traduction dans le live
                $url = "https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini"
                $outputPath = Join-Path $liveLocalizationDir "global.ini"
                Invoke-WebRequest -Uri $url -OutFile $outputPath

                Write-Host "Installation du dernier fichier de traduction dans le live, terminé."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
        }
        '2' {
            Write-Host "Vous avez choisi l'option 2."

            if (-not (Test-Path -Path $localization2 -PathType Container)) {
                Write-Host "Je ne trouve pas la version PTU. Veuillez vérifier que vous m'avez placé dans le répertoire StarCitizen."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
            else {
                # Création du fichier user.cfg dans le ptu
                Set-Content -Path "$localization2\user.cfg" -Value 'g_language = french_(france)'

                # Création des répertoires nécessaires dans le ptu
                $ptuLocalizationDir = Join-Path $localization2 "data\Localization\french_(france)"
                if (-not (Test-Path -Path $ptuLocalizationDir -PathType Container)) {
                    New-Item -Path $ptuLocalizationDir -ItemType Directory -Force
                }

                # Téléchargement et copie du fichier de traduction dans le ptu
                $url = "https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini"
                $outputPath = Join-Path $ptuLocalizationDir "global.ini"
                Invoke-WebRequest -Uri $url -OutFile $outputPath

                Write-Host "Installation du dernier fichier de traduction dans le PTU, terminé."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
        }
        '3' {
            Write-Host "Vous avez choisi l'option 3."

            # Téléchargement du fichier de traduction depuis Internet
            $url = "https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini"
            $outputPath = Join-Path $ScriptDir "global.ini"
            Invoke-WebRequest -Uri $url -OutFile $outputPath

            Write-Host "Récupération du dernier fichier de traduction, terminé."
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
        '4' {
            Write-Host "Vous avez choisi l'option 4."
            Start-Process "https://speedou.sc.tasul.fr/"
        }
        '5' {
            Create-Shortcut
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
        '6' {
            break
        }
        default {
            Write-Host "Choix invalide. Veuillez choisir une option valide."
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
    }
}
