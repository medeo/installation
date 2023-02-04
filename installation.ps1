clear
using namespace System.Management.Automation.Host
$continue = $true
while ($continue) {
    clear
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
    Write-Host "|                                 Version 2023.2                             |" -ForegroundColor Red 
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
    write-host "6. Désinstaller Extension Chrome"
    write-host "7. Préparation PC MEDEO"
    write-host "q. exit"
    write-host "--------------------------------------------------------"
    $choix = read-host "faire un choix "

    $path = "c:\medeoInstallation"
    If (!(test-path -PathType container $path)) {
        New-Item -ItemType Directory -Path $path
    }
    $LocalTempDir = "c:\medeoInstallation"

    function Install-Kligo {
        $urlKligo = "https://s3.eu-central-1.amazonaws.com/kligo/Kligo%20Setup%205.2.0.exe"
        $Kligo = "Kligo.exe"
        (New-Object System.Net.WebClient).DownloadFile($urlKligo, "$LocalTempDir\$Kligo"); & "$LocalTempDir\$Kligo" /silent /install;

    }

    function Install-Extension {
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
    function Install-Driver {
        $urlDriver = "https://kligo.s3.eu-central-1.amazonaws.com/USB-Signed-Win-Drv.zip"
        $Driver = "DriverWindows.zip"
        (New-Object System.Net.WebClient).DownloadFile($urlDriver, "$LocalTempDir\$Driver")
        Expand-Archive "$LocalTempDir\$Driver" -DestinationPath "$LocalTempDir\"
        pnputil /add-driver "$LocalTempDir\windrv\*inf" /install
    }

    switch ($choix) {
        1 {
            #Installation du Driver
            Install-Driver

            #Installation de Kligo
            Install-Kligo
        }
        2 { 
            #Installation de Kligo
            Install-Kligo
            clear   
        }
        3 {
            #Installation du Driver
            Install-Driver

            #Installation de Kligo
            Install-Kligo

            #Installation Chrome extension
            Install-Extension

        }
        4 {
            #Installation Chrome extension
            Install-Extension
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
            taskschd.msc

        }
        6 {
            #Désinstallation de l'extension Chrome
            param(
                $KeyPath = ""
            )
            Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist" -Name Lastkey -Value $KeyPath -Type String -Force
            Start-Process "regedit.exe" -args "-m"

        }
        7 {
            #Préparation PC MEDEO
            powercfg -change -monitor-timeout-ac 0
            powercfg -change -monitor-timeout-dc 0
            powercfg -change -standby-timeout-ac 0
            powercfg -change -standby-timeout-dc 0

            #Favoris
            $LocalTempDirChrome = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
            $urlFavoris = "https://raw.githubusercontent.com/medeo/installation/main/documents/Bookmarks"
            $Favoris = "Bookmarks"
            (New-Object System.Net.WebClient).DownloadFile($urlFavoris, "$LocalTempDirChrome\$Favoris")

            #Wallpaper
            $urlWallpaper = "https://raw.githubusercontent.com/medeo/installation/main/documents/wallpaper.png"
            $Wallpaper = "wallpaper.png"
            (New-Object System.Net.WebClient).DownloadFile($urlWallpaper, "$LocalTempDir\$Wallpaper")
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\" -Name "System"
            New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "Wallpaper" -Value "$LocalTempDir\wallpaper.png"  -PropertyType "String"
            New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "WallpaperStyle" -Value "4"  -PropertyType "String"
            stop-process -name explorer -force

        }
        ‘q’ { $continue = $false }
        default { Write-Host "Choix invalide" -ForegroundColor Red }
    }
}