#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "This script requires root privileges. Please run with sudo ./install.sh."
  exit
fi

read -p "Do you have Node.JS and NPM installed? [y/n] " nodenpm
case $nodenpm in
    [Nn]* ) sudo apt update; sudo apt -y install nodejs; sudo apt -y install npm;;
    [Yy]* ) echo "Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac

read -p "Do you have dotNET Core installed? [y/n] " dotnet
case $dotnet in
    [Nn]* ) sudo wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb; sudo dpkg -i packages-microsoft-prod.deb; sudo apt-get update; sudo apt-get install -y apt-transport-https; sudo apt-get install -y dotnet-sdk-5.0; sudo apt-get install -y aspnetcore-runtime-5.0; sudo apt-get install -y dotnet-runtime-5.0;;
    [Yy]* ) echo "Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac

read -p "Do you have Node.JS and NPM installed? [y/n] " postgresql
case $postgresql in
    [Nn]* ) sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'; sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -; sudo apt-get update; sudo apt-get -y install postgresql;;
    [Yy]* ) echo "Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac

read -p "Do you have pm2 installed? [y/n] " pm2
case $pm2 in
    [Nn]* ) sudo npm install pm2@latest -g;;
    [Yy]* ) echo "Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac

sudo git clone --recursive https://github.com/molenzwiebel/Impostor

cd Impostor/bot

read -p "Enter your Discord token: " token
read -p "Enter your PostgreSQL password (leave blank if you do not have one or just installed PostgreSQL: " password
if [ -z "$password" ]
then
    password=""
else
    password=":${password}"
fi
read -p "What is your bot's ID? Example: 764660478441160704: " id
sudo touch .env

echo "DISCORD_TOKEN=${token}" >> .env
echo "AU_CLIENT_DIR=../client/bin/Debug/netcoreapp3.1" >> .env
echo "DATABASE_URL=postgresql://postgres${password}@localhost:5432/postgres" >> .env
echo "BOT_INVITE_LINK=https://discord.com/api/oauth2/authorize?client_id=${id}&permissions=0&scope=bot" >> .env

sudo npm install
sudo pm2 start ./node_modules/.bin/tsc -w
sudo pm2 start node dist/index.js

cd ../client

sudo dotnet build

echo "Installation complete."
exit 0;
