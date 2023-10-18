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

# SIG # Begin signature block
# MIIbrwYJKoZIhvcNAQcCoIIboDCCG5wCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUllv/AnwJzBcl/5K5ZO5MyWOp
# ObSgghYfMIIDEjCCAfqgAwIBAgIQYSIKGf67K6RO2joB6O3jTDANBgkqhkiG9w0B
# AQsFADAhMR8wHQYDVQQDDBZBVEEgQXV0aGVudGljb2RlMDcwMzk4MB4XDTIzMTAx
# ODE2MzQzMloXDTI0MTAxODE2NTQzMlowITEfMB0GA1UEAwwWQVRBIEF1dGhlbnRp
# Y29kZTA3MDM5ODCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK5nL736
# 8AVJ3niNS2AyselgWSNdQoqlvftNrPuVbckH181pFRG+vKXcALoH7cwxeKec5qVv
# zUe1TWDvZphQxGtvhUdTxBcNPspIGsiwkqBNWDZqBVJ081GeBpUZEWsizY40DdXj
# 5mizNnSKzqgxui0AuKrjja/SLLB2LGFT0yopkTCwAP7Hthd8EDh9deaQahfWnQFD
# EvTigITzl0l8NGwpK7GX4yWI9wNsMX9Z6jjGXviFuGum7iy6fhDw3UDj52j14m2s
# z0OxB3MEygXsDYZo/U67aKHOgoCtDf/+FkGAxILt1pVd6es4RHudczu1uEIZdBJG
# dchs1TiUC6TE+t0CAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoG
# CCsGAQUFBwMDMB0GA1UdDgQWBBS3rct/nWrqeVyyNxjQMogd/Wx2yzANBgkqhkiG
# 9w0BAQsFAAOCAQEANBGnyYC9P8eVMdfI3+KtbvlMyde85038C8+HZpvGMU/N4AgC
# bBU35u2HlVMn6eC7dyPWG+48ZsfkdGe2tVb13i97I4b2uyN5/Cn1v86Q2rJ5wZ2F
# +41ziWIEGgPuvCIp2f8ee5jJkNoVXNN0ed4FDplGLRJgs61XeUQyE7aT8MinPINX
# Oabj7CPglCtcaZj0z3EOagrOI3Dgw/mVkz88FI3CsMUaA/aIxKzF/tSu1/buJqK3
# F9wuIDGKkm71MSV+Qnjyldv3D3NZ0PsxGwsOmcbkyFiKD78Gkgm5bz4gnOAZm2n8
# aGAWq1QbyMuFaLJE3m67s9VmyV9S1VAHh5X2rDCCBY0wggR1oAMCAQICEA6bGI75
# 0C3n79tQ4ghAGFowDQYJKoZIhvcNAQEMBQAwZTELMAkGA1UEBhMCVVMxFTATBgNV
# BAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIG
# A1UEAxMbRGlnaUNlcnQgQXNzdXJlZCBJRCBSb290IENBMB4XDTIyMDgwMTAwMDAw
# MFoXDTMxMTEwOTIzNTk1OVowYjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lD
# ZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEhMB8GA1UEAxMYRGln
# aUNlcnQgVHJ1c3RlZCBSb290IEc0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAv+aQc2jeu+RdSjwwIjBpM+zCpyUuySE98orYWcLhKac9WKt2ms2uexuE
# DcQwH/MbpDgW61bGl20dq7J58soR0uRf1gU8Ug9SH8aeFaV+vp+pVxZZVXKvaJNw
# wrK6dZlqczKU0RBEEC7fgvMHhOZ0O21x4i0MG+4g1ckgHWMpLc7sXk7Ik/ghYZs0
# 6wXGXuxbGrzryc/NrDRAX7F6Zu53yEioZldXn1RYjgwrt0+nMNlW7sp7XeOtyU9e
# 5TXnMcvak17cjo+A2raRmECQecN4x7axxLVqGDgDEI3Y1DekLgV9iPWCPhCRcKtV
# gkEy19sEcypukQF8IUzUvK4bA3VdeGbZOjFEmjNAvwjXWkmkwuapoGfdpCe8oU85
# tRFYF/ckXEaPZPfBaYh2mHY9WV1CdoeJl2l6SPDgohIbZpp0yt5LHucOY67m1O+S
# kjqePdwA5EUlibaaRBkrfsCUtNJhbesz2cXfSwQAzH0clcOP9yGyshG3u3/y1Yxw
# LEFgqrFjGESVGnZifvaAsPvoZKYz0YkH4b235kOkGLimdwHhD5QMIR2yVCkliWzl
# DlJRR3S+Jqy2QXXeeqxfjT/JvNNBERJb5RBQ6zHFynIWIgnffEx1P2PsIV/EIFFr
# b7GrhotPwtZFX50g/KEexcCPorF+CiaZ9eRpL5gdLfXZqbId5RsCAwEAAaOCATow
# ggE2MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFOzX44LScV1kTN8uZz/nupiu
# HA9PMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMA4GA1UdDwEB/wQE
# AwIBhjB5BggrBgEFBQcBAQRtMGswJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRp
# Z2ljZXJ0LmNvbTBDBggrBgEFBQcwAoY3aHR0cDovL2NhY2VydHMuZGlnaWNlcnQu
# Y29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNydDBFBgNVHR8EPjA8MDqgOKA2
# hjRodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290
# Q0EuY3JsMBEGA1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAQEAcKC/
# Q1xV5zhfoKN0Gz22Ftf3v1cHvZqsoYcs7IVeqRq7IviHGmlUIu2kiHdtvRoU9BNK
# ei8ttzjv9P+Aufih9/Jy3iS8UgPITtAq3votVs/59PesMHqai7Je1M/RQ0SbQyHr
# lnKhSLSZy51PpwYDE3cnRNTnf+hZqPC/Lwum6fI0POz3A8eHqNJMQBk1RmppVLC4
# oVaO7KTVPeix3P0c2PR3WlxUjG/voVA9/HYJaISfb8rbII01YBwCA8sgsKxYoA5A
# Y8WYIsGyWfVVa88nq2x2zm8jLfR+cWojayL/ErhULSd+2DrZ8LaHlv1b0VysGMNN
# n3O3AamfV6peKOK5lDCCBq4wggSWoAMCAQICEAc2N7ckVHzYR6z9KGYqXlswDQYJ
# KoZIhvcNAQELBQAwYjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IElu
# YzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEhMB8GA1UEAxMYRGlnaUNlcnQg
# VHJ1c3RlZCBSb290IEc0MB4XDTIyMDMyMzAwMDAwMFoXDTM3MDMyMjIzNTk1OVow
# YzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQD
# EzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGlu
# ZyBDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMaGNQZJs8E9cklR
# VcclA8TykTepl1Gh1tKD0Z5Mom2gsMyD+Vr2EaFEFUJfpIjzaPp985yJC3+dH54P
# Mx9QEwsmc5Zt+FeoAn39Q7SE2hHxc7Gz7iuAhIoiGN/r2j3EF3+rGSs+QtxnjupR
# PfDWVtTnKC3r07G1decfBmWNlCnT2exp39mQh0YAe9tEQYncfGpXevA3eZ9drMvo
# hGS0UvJ2R/dhgxndX7RUCyFobjchu0CsX7LeSn3O9TkSZ+8OpWNs5KbFHc02DVzV
# 5huowWR0QKfAcsW6Th+xtVhNef7Xj3OTrCw54qVI1vCwMROpVymWJy71h6aPTnYV
# VSZwmCZ/oBpHIEPjQ2OAe3VuJyWQmDo4EbP29p7mO1vsgd4iFNmCKseSv6De4z6i
# c/rnH1pslPJSlRErWHRAKKtzQ87fSqEcazjFKfPKqpZzQmiftkaznTqj1QPgv/Ci
# PMpC3BhIfxQ0z9JMq++bPf4OuGQq+nUoJEHtQr8FnGZJUlD0UfM2SU2LINIsVzV5
# K6jzRWC8I41Y99xh3pP+OcD5sjClTNfpmEpYPtMDiP6zj9NeS3YSUZPJjAw7W4oi
# qMEmCPkUEBIDfV8ju2TjY+Cm4T72wnSyPx4JduyrXUZ14mCjWAkBKAAOhFTuzuld
# yF4wEr1GnrXTdrnSDmuZDNIztM2xAgMBAAGjggFdMIIBWTASBgNVHRMBAf8ECDAG
# AQH/AgEAMB0GA1UdDgQWBBS6FtltTYUvcyl2mi91jGogj57IbzAfBgNVHSMEGDAW
# gBTs1+OC0nFdZEzfLmc/57qYrhwPTzAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0lBAww
# CgYIKwYBBQUHAwgwdwYIKwYBBQUHAQEEazBpMCQGCCsGAQUFBzABhhhodHRwOi8v
# b2NzcC5kaWdpY2VydC5jb20wQQYIKwYBBQUHMAKGNWh0dHA6Ly9jYWNlcnRzLmRp
# Z2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRSb290RzQuY3J0MEMGA1UdHwQ8MDow
# OKA2oDSGMmh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRS
# b290RzQuY3JsMCAGA1UdIAQZMBcwCAYGZ4EMAQQCMAsGCWCGSAGG/WwHATANBgkq
# hkiG9w0BAQsFAAOCAgEAfVmOwJO2b5ipRCIBfmbW2CFC4bAYLhBNE88wU86/GPvH
# UF3iSyn7cIoNqilp/GnBzx0H6T5gyNgL5Vxb122H+oQgJTQxZ822EpZvxFBMYh0M
# CIKoFr2pVs8Vc40BIiXOlWk/R3f7cnQU1/+rT4osequFzUNf7WC2qk+RZp4snuCK
# rOX9jLxkJodskr2dfNBwCnzvqLx1T7pa96kQsl3p/yhUifDVinF2ZdrM8HKjI/rA
# J4JErpknG6skHibBt94q6/aesXmZgaNWhqsKRcnfxI2g55j7+6adcq/Ex8HBanHZ
# xhOACcS2n82HhyS7T6NJuXdmkfFynOlLAlKnN36TU6w7HQhJD5TNOXrd/yVjmScs
# PT9rp/Fmw0HNT7ZAmyEhQNC3EyTN3B14OuSereU0cZLXJmvkOHOrpgFPvT87eK1M
# rfvElXvtCl8zOYdBeHo46Zzh3SP9HSjTx/no8Zhf+yvYfvJGnXUsHicsJttvFXse
# GYs2uJPU5vIXmVnKcPA3v5gA3yAWTyf7YGcWoWa63VXAOimGsJigK+2VQbc61RWY
# MbRiCQ8KvYHZE/6/pNHzV9m8BPqC3jLfBInwAM1dwvnQI38AC+R2AibZ8GV2QqYp
# hwlHK+Z/GqSFD/yYlvZVVCsfgPrA8g4r5db7qS9EFUrnEw4d2zc4GqEr9u3WfPww
# ggbCMIIEqqADAgECAhAFRK/zlJ0IOaa/2z9f5WEWMA0GCSqGSIb3DQEBCwUAMGMx
# CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMy
# RGlnaUNlcnQgVHJ1c3RlZCBHNCBSU0E0MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcg
# Q0EwHhcNMjMwNzE0MDAwMDAwWhcNMzQxMDEzMjM1OTU5WjBIMQswCQYDVQQGEwJV
# UzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xIDAeBgNVBAMTF0RpZ2lDZXJ0IFRp
# bWVzdGFtcCAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAo1NF
# hx2DjlusPlSzI+DPn9fl0uddoQ4J3C9Io5d6OyqcZ9xiFVjBqZMRp82qsmrdECmK
# HmJjadNYnDVxvzqX65RQjxwg6seaOy+WZuNp52n+W8PWKyAcwZeUtKVQgfLPywem
# MGjKg0La/H8JJJSkghraarrYO8pd3hkYhftF6g1hbJ3+cV7EBpo88MUueQ8bZlLj
# yNY+X9pD04T10Mf2SC1eRXWWdf7dEKEbg8G45lKVtUfXeCk5a+B4WZfjRCtK1ZXO
# 7wgX6oJkTf8j48qG7rSkIWRw69XloNpjsy7pBe6q9iT1HbybHLK3X9/w7nZ9MZll
# R1WdSiQvrCuXvp/k/XtzPjLuUjT71Lvr1KAsNJvj3m5kGQc3AZEPHLVRzapMZoOI
# aGK7vEEbeBlt5NkP4FhB+9ixLOFRr7StFQYU6mIIE9NpHnxkTZ0P387RXoyqq1AV
# ybPKvNfEO2hEo6U7Qv1zfe7dCv95NBB+plwKWEwAPoVpdceDZNZ1zY8SdlalJPrX
# xGshuugfNJgvOuprAbD3+yqG7HtSOKmYCaFxsmxxrz64b5bV4RAT/mFHCoz+8LbH
# 1cfebCTwv0KCyqBxPZySkwS0aXAnDU+3tTbRyV8IpHCj7ArxES5k4MsiK8rxKBMh
# SVF+BmbTO77665E42FEHypS34lCh8zrTioPLQHsCAwEAAaOCAYswggGHMA4GA1Ud
# DwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMI
# MCAGA1UdIAQZMBcwCAYGZ4EMAQQCMAsGCWCGSAGG/WwHATAfBgNVHSMEGDAWgBS6
# FtltTYUvcyl2mi91jGogj57IbzAdBgNVHQ4EFgQUpbbvE+fvzdBkodVWqWUxo97V
# 40kwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0Rp
# Z2lDZXJ0VHJ1c3RlZEc0UlNBNDA5NlNIQTI1NlRpbWVTdGFtcGluZ0NBLmNybDCB
# kAYIKwYBBQUHAQEEgYMwgYAwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2lj
# ZXJ0LmNvbTBYBggrBgEFBQcwAoZMaHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29t
# L0RpZ2lDZXJ0VHJ1c3RlZEc0UlNBNDA5NlNIQTI1NlRpbWVTdGFtcGluZ0NBLmNy
# dDANBgkqhkiG9w0BAQsFAAOCAgEAgRrW3qCptZgXvHCNT4o8aJzYJf/LLOTN6l0i
# kuyMIgKpuM+AqNnn48XtJoKKcS8Y3U623mzX4WCcK+3tPUiOuGu6fF29wmE3aEl3
# o+uQqhLXJ4Xzjh6S2sJAOJ9dyKAuJXglnSoFeoQpmLZXeY/bJlYrsPOnvTcM2Jh2
# T1a5UsK2nTipgedtQVyMadG5K8TGe8+c+njikxp2oml101DkRBK+IA2eqUTQ+OVJ
# dwhaIcW0z5iVGlS6ubzBaRm6zxbygzc0brBBJt3eWpdPM43UjXd9dUWhpVgmagNF
# 3tlQtVCMr1a9TMXhRsUo063nQwBw3syYnhmJA+rUkTfvTVLzyWAhxFZH7doRS4wy
# w4jmWOK22z75X7BC1o/jF5HRqsBV44a/rCcsQdCaM0qoNtS5cpZ+l3k4SF/Kwtw9
# Mt911jZnWon49qfH5U81PAC9vpwqbHkB3NpE5jreODsHXjlY9HxzMVWggBHLFAx+
# rrz+pOt5Zapo1iLKO+uagjVXKBbLafIymrLS2Dq4sUaGa7oX/cR3bBVsrquvczro
# SUa31X/MtjjA2Owc9bahuEMs305MfR5ocMB3CtQC4Fxguyj/OOVSWtasFyIjTvTs
# 0xf7UGv/B3cfcZdEQcm4RtNsMnxYL2dHZeUbc7aZ+WssBkbvQR7w8F/g29mtkIBE
# r4AQQYoxggT6MIIE9gIBATA1MCExHzAdBgNVBAMMFkFUQSBBdXRoZW50aWNvZGUw
# NzAzOTgCEGEiChn+uyukTto6Aejt40wwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcC
# AQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYB
# BAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFNJ7cq2TZ5+h
# I5O/fw92UKu9e1JYMA0GCSqGSIb3DQEBAQUABIIBAGKhk5CqV96MYF+MOBx0IgGJ
# 58OLe5YWq4XouDG4E+YYiu1oQHvYWQQmx5sTf3+BZoTLtSEWj7pzDITqBzFgYNpD
# DAKecGp3Gx/Mgxb6ZjmiOBZ2moj2bFg4XwzB80urocOPF5t8r7zh8mPz/yNyZM9+
# lXxoBA7CYCM80a9X0hcT867Q2yJTy/dg9Y+QB12sKjV3UII0C4QQXnJ+sWZHpuO2
# G8u5uh7XkGyKDp8bJhVFmJUzXI9GyYaA4mOlf4m6Suxmvtdu2cFPmD/VK0CrYgHx
# luP6mcRKZJWleAwrmPERqWWNTtjvUQ76jRhKP6mMGdOyrT8MvlHv/XASrq8lujuh
# ggMgMIIDHAYJKoZIhvcNAQkGMYIDDTCCAwkCAQEwdzBjMQswCQYDVQQGEwJVUzEX
# MBUGA1UEChMORGlnaUNlcnQsIEluYy4xOzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0
# ZWQgRzQgUlNBNDA5NiBTSEEyNTYgVGltZVN0YW1waW5nIENBAhAFRK/zlJ0IOaa/
# 2z9f5WEWMA0GCWCGSAFlAwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
# ATAcBgkqhkiG9w0BCQUxDxcNMjMxMDE4MTY0NTQwWjAvBgkqhkiG9w0BCQQxIgQg
# Ep0Rtp3BIavcUTRzhfs2mjIKHdKBi6c6jtLsVkqsf0EwDQYJKoZIhvcNAQEBBQAE
# ggIAIbA4BjFUV1RE7q09pTKrjhnZRIpmwXpbU1jKSH4Dbj2HAfStUwHDNLwtFJ8R
# uqppR/YGJ1of9oc+SOBJAKsuaHgBJuZm44dvzs/5mFI5ldYQP1QLUXmtE5Sc00gQ
# /zyIPcl7+mcs9olO+J6+SeZLhkJXf2b6SNgPqrmHWq8xbtI2njW6NCHu8iN+DtG0
# LvvBcwKlibe2y/hGP+obNTYBNB4+nQQhMVK9T0MFGTOGukF+2g1irxQGmJ3zE88G
# cz05gjD1XLuJDEX8vqn1+9JFfhzDuS4B2oi5nX5giiUoIhgkPPI1i2pg/l5hNHQP
# DV1jmbHWt25//2y72ZItZjTABXrYOE+1uvSVkvWGM/PdTdOiHeJjpDaTxJaPTYbm
# QNgSGy9TZMcHIbH7YfBU5piTSGGuift5Ie4GxuiQQtFZvA5crbMJw0K8sU0htzEs
# RflarvskAcrm//5bhJIeVSvvqzPRVQcLy1Vpwh7qYscMWwnh4Wj7a7HllRV8m0TU
# OHQb5mCSsjHmtkVxSUAGsMxNHJk2Yo+lwGbXu4H4i0uJHJh7IVqjs8g4WCLlprOP
# cjzF26pAjQiAJDmjHAl49+Qn0AJSO0AQWlzs5qQ2z1gAqXnWwBzLeFBPeMXCCmrS
# dXZtvsRXHts8qNKOvlpDoQjTy+dGFDe89cJOgQ/D0hwheCA=
# SIG # End signature block
