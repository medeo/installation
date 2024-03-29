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

New-Item -Path "c:\" -Name "medeoInstallation" -ItemType "directory"
$LocalTempDir = "c:\medeoInstallation"

#Driver
$urlDriver = "https://kligo.s3.eu-central-1.amazonaws.com/USB-Signed-Win-Drv.zip"
$Driver = "DriverWindows.zip"
(New-Object System.Net.WebClient).DownloadFile($urlDriver, "$LocalTempDir\$Driver")
Expand-Archive "$LocalTempDir\$Driver" -DestinationPath "$LocalTempDir\"
pnputil /add-driver "c:\medeoInstallation\windrv\*inf" /install

#Kligo
$urlKligo = "https://kligo-rollouts112226-dev.s3.eu-west-1.amazonaws.com/staged/Kligo+Setup+6.0.0-develop.15.exe"
$Kligo = "Kligo.exe"
(New-Object System.Net.WebClient).DownloadFile($urlKligo, "$LocalTempDir\$Kligo"); & "$LocalTempDir\$Kligo" /silent /install;

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
