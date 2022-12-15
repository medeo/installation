New-Item -Path "c:\" -Name "medeoInstallation" -ItemType "directory"

$LocalTempDir = "c:\medeoInstallation"

$urlDriver = "https://raw.githubusercontent.com/medeo/installation/main/New-ChromeExtension.ps1"
$ChromeExtension = "New-ChromeExtension.ps1"
(New-Object System.Net.WebClient).DownloadFile($urlDriver, "$LocalTempDir\$ChromeExtension")

New-ChromeExtension -ExtensionID 'ilbdbafpgbnlnmlpojeaiedhocikipjm'
