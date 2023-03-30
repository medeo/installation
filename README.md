# installation Kligo sur PC (avec PowerShell)

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/medeo/installation/main/installation.ps1'))
```

# installation Kligo sur Mac

```
curl https://raw.githubusercontent.com/medeo/installation/main/ecgmedeo.sh -o ecgmedeo.sh
chmod +x ecgmedeo.sh
./ecgmedeo.sh
```


# installation Tablette

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/medeo/installation/main/install.ps1'))
```
