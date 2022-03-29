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

$urlDriver = "https://kligo.s3.eu-central-1.amazonaws.com/USB-Signed-Win-Drv.zip"
$Driver = "DriverWindows.zip"
(New-Object System.Net.WebClient).DownloadFile($urlDriver, "$LocalTempDir\$Driver")

Expand-Archive "$LocalTempDir\$Driver" -DestinationPath "$LocalTempDir\"

pnputil /add-driver "c:\medeoInstallation\windrv\*inf" /install
