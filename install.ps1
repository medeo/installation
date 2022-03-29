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
$urlKligo = "https://s3.eu-central-1.amazonaws.com/kligo/Kligo%20Setup%205.2.0.exe"
$Kligo = "Kligo.exe"
(New-Object System.Net.WebClient).DownloadFile($urlKligo, "$LocalTempDir\$Kligo"); & "$LocalTempDir\$Kligo" /silent /install;

#TeamViewer
$urlTV = "https://download.teamviewer.com/download/TeamViewer_Setup_x64.exe"
$TeamViewer = "Teamviewer.exe"
(New-Object System.Net.WebClient).DownloadFile($urlTV, "$LocalTempDir\$TeamViewer"); & "$LocalTempDir\$TeamViewer" /silent /install; 

#Anydesk
$urlAnyDesk = "https://download.anydesk.com/AnyDesk.exe"
$AnyDesk = "AnyDesk.exe"
(New-Object System.Net.WebClient).DownloadFile($urlAnyDesk, "$LocalTempDir\$AnyDesk"); & "$LocalTempDir\$AnyDesk" /silent /install; 


###Chrome
$ChromeInstaller = "ChromeInstaller.exe"; 
$urlChrome = "http://dl.google.com/chrome/install/chrome_installer.exe"
(new-object System.Net.WebClient).DownloadFile($urlChrome, "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; 


###Shortcut Medeo
$WShell = New-Object -comObject WScript.Shell
$Shortcut = $WShell.CreateShortcut("$Home\Desktop\Medeo.lnk")
$Shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$Shortcut.Arguments = "-kiosk https://medeo.care"
$shortcut.IconLocation = "\\fileserver\share directory\icon.ico"
$Shortcut.Save()

<#

#URLMedeo
$urlURLMEDEO = "https://raw.githubusercontent.com/medeo/installation/main/kiosk.csv"
$URLMEDEO = "kiosk.csv"
(New-Object System.Net.WebClient).DownloadFile($urlURLMEDEO, "$LocalTempDir\$URLMEDEO")

$destination = 'F:\destination'
$chromeroot = 'C:\Program Files (x86)\Google\Chrome'
$workingdir = 'C:\script'
$input = Import-Csv .\kiosk.csv
 
function Create-Shortcut
{
$Shell = New-Object -ComObject ("WScript.Shell")
$ShortCut = $Shell.CreateShortcut("$destination\$URLTitle.lnk")
$ShortCut.TargetPath="$chromeroot\Application\chrome.exe"
$ShortCut.Arguments="--kiosk $URL"
$ShortCut.WorkingDirectory = "$chromeroot\Application";
$ShortCut.WindowStyle = 1;
$ShortCut.IconLocation = "$chromeroot\Application\chrome.exe, 0";
$ShortCut.Description = "";
$ShortCut.Save()
}
 
ForEach ($item in $input){
    $URLTitle = $($item.name)
    $URL = $($item.url)
    Create-Shortcut
    }
#>
