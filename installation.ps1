using namespace System.Management.Automation.Host
$continue = $true
while ($continue) {
    Write-Host "`n"
    Write-Host " ____________________________________________________________________________ " -ForegroundColor Red 
    Write-Host "|                                                                            |" -ForegroundColor Red 
    Write-Host "|    "  -ForegroundColor Red -NoNewline; Write-Host "                  " -ForegroundColor Green -NoNewline; Write-Host "                                                      |" -ForegroundColor Red    
    Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "          __    __     ______     _____     ______     ______            " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
    Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "         /\ '-./  \   /\  ___\   /\  __-.  /\  ___\   /\  __ \           " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
    Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "         \ \ \-./\ \  \ \  __\   \ \ \/\ \ \ \  __\   \ \ \/\ \          " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
    Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "          \ \_\ \ \_\  \ \_____\  \ \____-  \ \_____\  \ \_____\         " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
    Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "           \/_/  \/_/   \/_____/   \/____/   \/_____/   \/_____/         " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
    Write-Host "|                                                                            |" -ForegroundColor Red 
    Write-Host "|                                 Version 2022.0                             |" -ForegroundColor Red 
    Write-Host "|                             contact@medeo-health.com                       |" -ForegroundColor Red 
    Write-Host "|____________________________________________________________________________|" -ForegroundColor Red 
    Write-Host "|                                                                            |" -ForegroundColor Red 
    Write-Host "|                                   Created by                               |" -ForegroundColor Red 
    Write-Host "|                                     Medeo                                  |" -ForegroundColor Red 
    Write-Host "|____________________________________________________________________________|" -ForegroundColor Red 
    write-host " "
    write-host " "
    write-host " "
    write-host " "
    write-host " "
    write-host "--------------------------------------------------------"
    write-host "1. Installer Kligo + driver"
    write-host "2. Installer Kligo"
    write-host "3. Installer Kligo + Driver + Extension Chrome"
    write-host "4. Installer Extension Chrome"
    write-host "5. Installer task pour cohabitation avec VitalZen"
    write-host "q. exit"
    write-host "--------------------------------------------------------"
    $choix = read-host "faire un choix "

    $path = "c:\medeoInstallation"
    If (!(test-path -PathType container $path)) {
        New-Item -ItemType Directory -Path $path
    }
    $LocalTempDir = "c:\medeoInstallation"

    switch ($choix) {
        1 {
            #Driver
            $urlDriver = "https://kligo.s3.eu-central-1.amazonaws.com/USB-Signed-Win-Drv.zip"
            $Driver = "DriverWindows.zip"
            (New-Object System.Net.WebClient).DownloadFile($urlDriver, "$LocalTempDir\$Driver")
            Expand-Archive "$LocalTempDir\$Driver" -DestinationPath "$LocalTempDir\"
            pnputil /add-driver "$LocalTempDir\windrv\*inf" /install

            #Kligo
            $urlKligo = "https://kligo-rollouts112226-dev.s3.eu-west-1.amazonaws.com/staged/Kligo+Setup+6.0.0-develop.15.exe"
            $Kligo = "Kligo.exe"
            (New-Object System.Net.WebClient).DownloadFile($urlKligo, "$LocalTempDir\$Kligo"); & "$LocalTempDir\$Kligo" /silent /install;
        }
        2 { 
            #Kligo
            $urlKligo = "https://kligo-rollouts112226-dev.s3.eu-west-1.amazonaws.com/staged/Kligo+Setup+6.0.0-develop.15.exe"
            $Kligo = "Kligo.exe"
            (New-Object System.Net.WebClient).DownloadFile($urlKligo, "$LocalTempDir\$Kligo"); & "$LocalTempDir\$Kligo" /silent /install;   
        }
        3 {
            #Driver
            $urlDriver = "https://kligo.s3.eu-central-1.amazonaws.com/USB-Signed-Win-Drv.zip"
            $Driver = "DriverWindows.zip"
            (New-Object System.Net.WebClient).DownloadFile($urlDriver, "$LocalTempDir\$Driver")
            Expand-Archive "$LocalTempDir\$Driver" -DestinationPath "$LocalTempDir\"
            pnputil /add-driver "$LocalTempDir\windrv\*inf" /install

            #Kligo
            $urlKligo = "https://kligo-rollouts112226-dev.s3.eu-west-1.amazonaws.com/staged/Kligo+Setup+6.0.0-develop.15.exe"
            $Kligo = "Kligo.exe"
            (New-Object System.Net.WebClient).DownloadFile($urlKligo, "$LocalTempDir\$Kligo"); & "$LocalTempDir\$Kligo" /silent /install;

            #Install Kligo Chrome extension
            $regLocation = 'Software\Policies\Google\Chrome\ExtensionInstallForcelist'
            # Each extension if you want to force install more than 1 extension needs its own key #

            If (!(Test-Path "HKLM:\$regLocation")) {
                Write-Verbose -Message "No Registry Path, setting count to: 0"
                [int]$Count = 0
                Write-Verbose -Message "Count is now $Count" 
                New-Item -Path "HKLM:\$regLocation" -Force

            }

            Else {
                Write-Verbose -Message "Keys found, counting them..."
                [int]$Count = (Get-Item "HKLM:\$regLocation").Count
                Write-Verbose -Message "Count is now $Count"
            }


            $regKey = $Count + 1
            Write-Verbose -Message "Creating reg key with value $regKey"

            $regData = "ilbdbafpgbnlnmlpojeaiedhocikipjm;https://clients2.google.com/service/update2/crx"
            New-ItemProperty -Path "HKLM:\$regLocation" -Name $regKey -Value $regData -PropertyType STRING -Force

        }
        4 {
            #Install Kligo Chrome extension
            $regLocation = 'Software\Policies\Google\Chrome\ExtensionInstallForcelist'
            # Each extension if you want to force install more than 1 extension needs its own key #

            If (!(Test-Path "HKLM:\$regLocation")) {
                Write-Verbose -Message "No Registry Path, setting count to: 0"
                [int]$Count = 0
                Write-Verbose -Message "Count is now $Count" 
                New-Item -Path "HKLM:\$regLocation" -Force

            }

            Else {
                Write-Verbose -Message "Keys found, counting them..."
                [int]$Count = (Get-Item "HKLM:\$regLocation").Count
                Write-Verbose -Message "Count is now $Count"
            }


            $regKey = $Count + 1
            Write-Verbose -Message "Creating reg key with value $regKey"

            $regData = "ilbdbafpgbnlnmlpojeaiedhocikipjm;https://clients2.google.com/service/update2/crx"
            New-ItemProperty -Path "HKLM:\$regLocation" -Name $regKey -Value $regData -PropertyType STRING -Force
        }
        5 {
            #VITALZEN
            $urlVZL = "https://raw.githubusercontent.com/medeo/installation/main/documents/LAUNCHER_VITALZEN.xml"
            $urlVZR = "https://raw.githubusercontent.com/medeo/installation/main/documents/REMOVER_VITALZEN.xml"
            $urlVZB = "https://raw.githubusercontent.com/medeo/installation/main/documents/vitalzenremover.bat"
            $VZL = "LAUNCHER_VITALZEN.xml"
            $VZR = "REMOVER_VITALZEN.xml"
            $VZB = "vitalzenremover.bat"
                (New-Object System.Net.WebClient).DownloadFile($urlVZL, "$LocalTempDir\$VZL")
                (New-Object System.Net.WebClient).DownloadFile($urlVZR, "$LocalTempDir\$VZR")
                (New-Object System.Net.WebClient).DownloadFile($urlVZB, "$LocalTempDir\$VZB")
            
            Register-ScheduledTask -TaskName "LAUNCHER_VITALZEN" -Xml (Get-Content "$LocalTempDir\$VZL" | Out-String) -Force    
            Register-ScheduledTask -TaskName "REMOVER_VITALZEN" -Xml (Get-Content "$LocalTempDir\$VZR" | Out-String) -Force    
            taskmgr

        }
        6 {
            #Désinstallation de l'extension Chrome

        }
        ‘q’ { $continue = $false }
        default { Write-Host "Choix invalide" -ForegroundColor Red }
    }
}