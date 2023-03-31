# installation Kligo sur PC (avec PowerShell)

1. Installer Kligo + driver
2. Installer Kligo
3. Installer Kligo + Driver + Extension Chrome
4. Installer Extension Chrome
5. Installer task pour cohabitation avec VitalZen
6. Desinstaller Extension Chrome
7. Preparation PC MEDEO
8. [TODO] Affichage de l'IP local
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/medeo/installation/main/installation.ps1'))
```

# installation Kligo sur Mac

1. Installation de Kligo
2. Installation du service FTP
3. Affichage de l'IP local
```
curl https://raw.githubusercontent.com/medeo/installation/main/installation-medeo-mac.sh -o installation-medeo-mac.sh
chmod +x installation-medeo-mac.sh
./installation-medeo-mac.sh

```


# installation Tablette

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/medeo/installation/main/install.ps1'))
```
