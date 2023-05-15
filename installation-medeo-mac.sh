#!/usr/bin/env bash
clear
echo "____________________________________________________________________________"
echo "|                                                                          |"
echo "|            __    __     ______     _____     ______     ______           |" 
echo "|           /\ '-./  \   /\  ___\   /\  __-.  /\  ___\   /\  __ \          |" 
echo "|           \ \ \-./\ \  \ \  __\   \ \ \/\ \ \ \  __\   \ \ \/\ \         |" 
echo "|            \ \_\ \ \_\  \ \_____\  \ \____-  \ \_____\  \ \_____\        |" 
echo "|             \/_/  \/_/   \/_____/   \/____/   \/_____/   \/_____/        |" 
echo "|                                                                          |"
echo "|                                 Version 2023.0                           |"
echo "|                             contact@medeo-health.com                     |"
echo "|__________________________________________________________________________|"
echo "|                                                                          |"
echo "|                                   Created by                             |"
echo "|                                     Medeo                                |"
echo "|__________________________________________________________________________|"

echo -e "\n"


user=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ {print $3}')
#echo "${user}"
URLDOCKER=https://kligo.s3.eu-central-1.amazonaws.com/DockerIntel.dmg
URLKLIGO=https://kligo.s3.eu-central-1.amazonaws.com/Kligo-6.0.0-develop.15.dmg
cd ~/Downloads/
if [[ $(uname -m) == 'arm64' ]];  then 
	echo M1 
    URLDOCKER=https://kligo.s3.eu-central-1.amazonaws.com/DockerAppleSilicon.dmg
else echo Intel
fi


read -r -p "Installation de Kligo? [Y/n] " response1
case "$response1" in
    [nN][oO]|[nN]) 
        echo "Pas d'installation de Kligo"
        ;;
    *)
        curl -0 "$URLKLIGO" -o Kligo.dmg
		sudo hdiutil attach Kligo.dmg
		sleep 1
		#sudo /Volumes/Kligo/Kligo.app/Contents/MacOS/install --user=${user}
		sudo cp -rf "/Volumes/Kligo 6.0.0-develop.15/Kligo.app" /Applications
		sleep 1
		sudo hdiutil detach "/Volumes/Kligo 6.0.0-develop.15"
		open -a Kligo
        ;;
esac

read -r -p "Installation du service ECG? [Y/n] " response2
case "$response2" in
    [nN][oO]|[nN]) 
        echo "Pas d'installation du service ECG"
        ;;
    *)
        echo "Installation du service ECG"
        curl -0 "$URLDOCKER" -o Docker.dmg
		sudo hdiutil attach Docker.dmg
		sleep 1
		sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --user=${user}
		sleep 1
		sudo hdiutil detach /Volumes/Docker
		open -a Docker
		echo "Parametrer Docker memoire min + demarrage au login"
		read -p "Press any key to continue... "
		docker run -d  --name=ftp --restart always  -p 21:21    -p 21000-21010:21000-21010    -v "$HOME/Desktop/ecg:/ftp/oedem"  -e USERS="oedem|ecg"  delfer/alpine-ftp-server
		/sbin/ifconfig | grep 'inet '
        ;;
esac

read -r -p "Connaitre l'adresse IP [Y/n]" response1
case "$response1" in
    [nN][oO]|[nN]) 
        ;;
    *)
        /sbin/ifconfig | grep 'inet '
        ;;
esac
