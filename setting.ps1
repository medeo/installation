powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0

#Favoris
$LocalTempDir = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
$urlFavoris = "https://raw.githubusercontent.com/medeo/installation/documents/main/Bookmarks"
$Favoris = "Bookmarks"
(New-Object System.Net.WebClient).DownloadFile($urlFavoris, "$LocalTempDir\$Favoris")

#Wallpaper
$LocalTempDir = "c:\medeoInstallation"
$urlWallpaper = "https://raw.githubusercontent.com/medeo/installation/documents/main/wallpaper.png"
$Wallpaper = "wallpaper.png"
(New-Object System.Net.WebClient).DownloadFile($urlWallpaper, "$LocalTempDir\$Wallpaper")
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\" -Name "System"
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "Wallpaper" -Value "c:\medeoInstallation\wallpaper.png"  -PropertyType "String"
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "WallpaperStyle" -Value "4"  -PropertyType "String"
stop-process -name explorer -force
