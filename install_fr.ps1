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
    $shortcut.TargetPath = $MyInvocation.MyCommand.Path
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
                Invoke-WebRequest -Uri $url -OutFile $outputPath

                Write-Host "Installation du dernier fichier de traduction dans le live, terminé."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
        }
        '2' {
            Clear-Host
            Write-Host "Traduction du PTU"
            # Vérification de la présence du Live
            Write-Host "Vérification de la présence du PTU"

            if (-not (Test-Path -Path $localization2 -PathType Container)) {
                Write-Host "Je ne trouve pas la version PTU. Veuillez vérifier que vous m'avez placé dans le répertoire StarCitizen."
                Read-Host "Appuyez sur Entrée pour continuer..."
            }
            else {
                # Création du fichier user.cfg dans le ptu
                Set-Content -Path "$localization2\user.cfg" -Value 'g_language = french_(france)'

                # Création des répertoires nécessaires dans le ptu
                Write-Host "Création des répertoires nécessaires dans le PTU"
                $ptuLocalizationDir = Join-Path $localization2 "data\Localization\french_(france)"
                if (-not (Test-Path -Path $ptuLocalizationDir -PathType Container)) {
                    New-Item -Path $ptuLocalizationDir -ItemType Directory -Force
                }

                # Téléchargement et copie du fichier de traduction dans le ptu
                Write-Host "Téléchargement et copie du fichier de traduction dans le PTU"
                $url = "https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini"
                $outputPath = Join-Path $ptuLocalizationDir "global.ini"
                Invoke-WebRequest -Uri $url -OutFile $outputPath

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
            Invoke-WebRequest -Uri $url -OutFile $outputPath

            Write-Host "Récupération du dernier fichier de traduction, terminé."
            Read-Host "Appuyez sur Entrée pour continuer..."
        }
        '4' {
            Clear-Host
            Write-Host "Ouverture de la page internet"
            Start-Process "https://speedou.sc.tasul.fr/"
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

# SIG # Begin signature block
# MIIF0wYJKoZIhvcNAQcCoIIFxDCCBcACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUib/N5znfXbXXl4fBnE97PV9t
# ONCgggNMMIIDSDCCAjCgAwIBAgIQaYOAw5aCEKJMOMPCq5dBLzANBgkqhkiG9w0B
# AQsFADA8MRAwDgYDVQQDDAdET1VTUEVFMSgwJgYJKoZIhvcNAQkBFhlzcGVlZG91
# LnRtLnByb2RAZ21haWwuY29tMB4XDTIzMTAxNDEyNDQxOFoXDTM4MTIzMTIyMDAw
# MFowPDEQMA4GA1UEAwwHRE9VU1BFRTEoMCYGCSqGSIb3DQEJARYZc3BlZWRvdS50
# bS5wcm9kQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
# AN+f2OaAAr+NG/EIHMfdM7oGSM30SA2EkBQkHXwdUxPxqaQm8OKyl24czBpUk+ng
# QRhICPQCRe7KILfFmX0U2WqDh10J/onALDx3dZ27iVRl1hby1KO9Bx4dVYhSrdrT
# Nzmkp9heBGDv/GZVst9JV9OkRlc5MLL7tF6NdBtqJ3rS/ue5IAOay87uVXwPuqcv
# tgiP6fyL8dgthyCE1ANu95fQO4pnRb2dnybtem6ck2y/92KotEZd6M9/5/21GSoa
# ShTMNToAKlMY8VXAln0Mm80HizcFpOTnrKRvl56Bhzt2WKsbjpo7iBb71ziX5sKY
# TVzuIGdTStHMfoNpoHmM95ECAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgWgMBMGA1Ud
# JQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBTpnNv0nWvsRVSlFSWhBw1dPwR1ZTAN
# BgkqhkiG9w0BAQsFAAOCAQEAQ1VoAFn4kYMQZrkKftgzBsV7PXvWM4emSQp/eB4m
# KmkIh/aWfuNJNdsOMTdBpWQik7vto/ohqa8jZokQWzDPQX6nYkCtGjknRvMXXmP2
# vawk9GdGxASpIJesulSBDxKoSno7J2CBxRhjFH+ORCD1H1hcRj9cja9Ht0JUwMcV
# tOH8t/I9kFxYzGA4u09sR+a5KwfsL2fNlAOwPI+yerEKB3asNR5TQ1sMrdGtyYcu
# dw/MFkvifPaZ/GiPYL+e4ikf31o3MeAb3P2TvJgtNtTTdDrepNzSVEdhJA0Bw650
# ZBXLPy8LYaNJf7dTav1q4UlZ+07sei7seyMBE0xtGhl3tDGCAfEwggHtAgEBMFAw
# PDEQMA4GA1UEAwwHRE9VU1BFRTEoMCYGCSqGSIb3DQEJARYZc3BlZWRvdS50bS5w
# cm9kQGdtYWlsLmNvbQIQaYOAw5aCEKJMOMPCq5dBLzAJBgUrDgMCGgUAoHgwGAYK
# KwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIB
# BDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU
# zvVCVQc22Mj9nMna8gPvOuyNdEYwDQYJKoZIhvcNAQEBBQAEggEAYO3jaAjL/agl
# SNcxoEeFViT26otUo3XTyL1RNU1pL/JzbbKovqihOHx1g9879yCBwgcW1EWBp5P+
# hyPHtUMRK0xM3DhHDVQcZQRvv/rze5wnLGdSPBRzkKucroTF35zAHR4hklCBVBFm
# qpV6bbraZ12jN6fOw53jl6sv+FYXtyoLDr3IrxzxZ+OAzo/MhE196s+U15DHLj+u
# Q+Skse01no9XpGpDXjGHEPrMqCcgevHFRbSWJFdUcVtsCt4PgBnPplNYIj50iFSy
# YfHAOcxgSWhRpUrvfmBlBEOoWno+IQH1HJXYIPDnx5W55BOgVAUAov9MqDGK2kl9
# wUCrv35E6Q==
# SIG # End signature block
