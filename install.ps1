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

#Suppression 
$urlsuppressionOffice = "https://outlookdiagnostics.azureedge.net/sarasetup/SetupProd_OffScrub.exe"
$suppressionOffice = "SetupProdOffScrub.exe"
(New-Object System.Net.WebClient).DownloadFile($urlsuppressionOffice, "$LocalTempDir\$suppressionOffice"); & "$LocalTempDir\$suppressionOffice" /install; 

###Chrome
$ChromeInstaller = "ChromeInstaller.exe"; 
$urlChrome = "http://dl.google.com/chrome/install/chrome_installer.exe"
(new-object System.Net.WebClient).DownloadFile($urlChrome, "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; 

#ICOMEDEO
$urlICOMEDEO = "https://raw.githubusercontent.com/medeo/installation/documents/ac065c9f89d9f98945b6e9adc1d059e750ee1a1a/Medeo.ico"
$ICOMEDEO = "Medeo.ico"
(New-Object System.Net.WebClient).DownloadFile($urlICOMEDEO, "$LocalTempDir\$ICOMEDEO")

###Shortcut Medeo
$WShell = New-Object -comObject WScript.Shell
$Shortcut = $WShell.CreateShortcut("$Home\Desktop\Medeo.lnk")
$Shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$Shortcut.Arguments = "https://medeo.care"
$shortcut.IconLocation = "$LocalTempDir\Medeo.ico"
$Shortcut.Save()

#Desinstaller OneDrive
ps onedrive | Stop-Process -Force
start-process "$env:windir\SysWOW64\OneDriveSetup.exe" "/uninstall"

#Pour les PC Acer 03/22
<#la liste :

Get-WmiObject -Class Win32_Product | Select-Object -Property Name
 ou
$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, UninstallString
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString
$INSTALLED | ?{ $_.DisplayName -ne $null } | sort-object -Property DisplayName -Unique | Format-Table -AutoSize

#>

#Uninstall Firefox
$SEARCH = 'firefox'
$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, UninstallString
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString
$RESULT = $INSTALLED | ? { $_.DisplayName -ne $null } | Where-Object { $_.DisplayName -match $SEARCH } 
if ($RESULT.uninstallstring -like "msiexec*") {
    $ARGS = (($RESULT.UninstallString -split ' ')[1] -replace '/I', '/X ') + ' /q'
    Start-Process msiexec.exe -ArgumentList $ARGS -Wait
}
else {
    $UNINSTALL_COMMAND = (($RESULT.UninstallString -split '\"')[1])
    $UNINSTALL_ARGS = (($RESULT.UninstallString -split '\"')[2]) + ' /S'
    Start-Process $UNINSTALL_COMMAND -ArgumentList $UNINSTALL_ARGS -Wait
}

#Uninstall Office 16 Extensibility Component
$SEARCH = 'Office 16 Click-to-Run Extensibility Component'
$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, UninstallString
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString
$RESULT = $INSTALLED | ? { $_.DisplayName -ne $null } | Where-Object { $_.DisplayName -match $SEARCH } 
if ($RESULT.uninstallstring -like "msiexec*") {
    $ARGS = (($RESULT.UninstallString -split ' ')[1] -replace '/I', '/X ') + ' /q'
    Start-Process msiexec.exe -ArgumentList $ARGS -Wait
}
else {
    $UNINSTALL_COMMAND = (($RESULT.UninstallString -split '\"')[1])
    $UNINSTALL_ARGS = (($RESULT.UninstallString -split '\"')[2]) + ' /S'
    Start-Process $UNINSTALL_COMMAND -ArgumentList $UNINSTALL_ARGS -Wait
}

#Uninstall Office 16 Click-to-Run Localization Component
$SEARCH = 'Office 16 Click-to-Run Localization Component'
$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, UninstallString
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString
$RESULT = $INSTALLED | ? { $_.DisplayName -ne $null } | Where-Object { $_.DisplayName -match $SEARCH } 
if ($RESULT.uninstallstring -like "msiexec*") {
    $ARGS = (($RESULT.UninstallString -split ' ')[1] -replace '/I', '/X ') + ' /q'
    Start-Process msiexec.exe -ArgumentList $ARGS -Wait
}
else {
    $UNINSTALL_COMMAND = (($RESULT.UninstallString -split '\"')[1])
    $UNINSTALL_ARGS = (($RESULT.UninstallString -split '\"')[2]) + ' /S'
    Start-Process $UNINSTALL_COMMAND -ArgumentList $UNINSTALL_ARGS -Wait
}


#Uninstall Forge of Empires
$SEARCH = 'Forge of Empires'
$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, UninstallString
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString
$RESULT = $INSTALLED | ? { $_.DisplayName -ne $null } | Where-Object { $_.DisplayName -match $SEARCH } 
if ($RESULT.uninstallstring -like "msiexec*") {
    $ARGS = (($RESULT.UninstallString -split ' ')[1] -replace '/I', '/X ') + ' /q'
    Start-Process msiexec.exe -ArgumentList $ARGS -Wait
}
else {
    $UNINSTALL_COMMAND = (($RESULT.UninstallString -split '\"')[1])
    $UNINSTALL_ARGS = (($RESULT.UninstallString -split '\"')[2]) + ' /S'
    Start-Process $UNINSTALL_COMMAND -ArgumentList $UNINSTALL_ARGS -Wait
}



#Uninstall ExpressVPN
$SEARCH = 'ExpressVPN'
$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, UninstallString
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString
$RESULT = $INSTALLED | ? { $_.DisplayName -ne $null } | Where-Object { $_.DisplayName -match $SEARCH } 
if ($RESULT.uninstallstring -like "msiexec*") {
    $ARGS = (($RESULT.UninstallString -split ' ')[1] -replace '/I', '/X ') + ' /q'
    Start-Process msiexec.exe -ArgumentList $ARGS -Wait
}
else {
    $UNINSTALL_COMMAND = (($RESULT.UninstallString -split '\"')[1])
    $UNINSTALL_ARGS = (($RESULT.UninstallString -split '\"')[2]) + ' /S'
    Start-Process $UNINSTALL_COMMAND -ArgumentList $UNINSTALL_ARGS -Wait
}


#Uninstall Norton
$SEARCH = 'Norton Security Ultra'
$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, UninstallString
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString
$RESULT = $INSTALLED | ? { $_.DisplayName -ne $null } | Where-Object { $_.DisplayName -match $SEARCH }
if ($RESULT.uninstallstring -like "msiexec*") {
    $ARGS = (($RESULT.UninstallString -split ' ')[1] -replace '/I', '/X ') + ' /q'
    Start-Process msiexec.exe -ArgumentList $ARGS -Wait
}
else {
    $UNINSTALL_COMMAND = (($RESULT.UninstallString -split '\"')[1])
    $UNINSTALL_ARGS = (($RESULT.UninstallString -split '\"')[2]) + ' /S'
    Start-Process $UNINSTALL_COMMAND -ArgumentList $UNINSTALL_ARGS -Wait
}
