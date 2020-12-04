#!/bin/bash
sudo rm -rf Impostor
if [ "$EUID" -ne 0 ]
  then echo "This script requires root privileges. Please run with sudo ./install.sh."
  exit
fi
read -p "Do you have Node.JS and NPM installed? [y/n] " nodenpm
read -p "Do you have dotNET Core installed? [y/n] " dotnet
read -p "Do you have PostgreSQL installed? [y/n] " postgresql
read -p "Do you have pm2 installed? [y/n] " pm2
read -p "Enter your Discord token: " token
read -p "What is your bot's ID? Example: 764660478441160704: " id
read -p "Enter your PostgreSQL password (leave blank if you do not have one or just installed PostgreSQL): " password
case $nodenpm in
    [Nn]* ) sudo apt update; sudo apt -y install nodejs; sudo apt -y install npm;;
    [Yy]* ) echo "Node.JS and NPM is installed. Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac
case $dotnet in
    [Nn]* ) wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb; sudo dpkg -i packages-microsoft-prod.deb; sudo apt-get update; sudo apt-get install -y apt-transport-https; sudo apt-get install -y dotnet-sdk-5.0; sudo apt-get install -y aspnetcore-runtime-5.0; sudo apt-get install -y dotnet-runtime-5.0;;
    [Yy]* ) echo "dotNET Core is installed. Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac
case $postgresql in
    [Nn]* ) sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'; sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -; sudo apt-get update; sudo apt-get -y install postgresql;;
    [Yy]* ) echo "PostgreSQL is installed. Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac
case $pm2 in
    [Nn]* ) sudo npm install pm2@latest -g;;
    [Yy]* ) echo "PM2 is installed. Proceeding with install.";;
    * ) echo "Please answer yes or no.";;
esac
pm2 kill
git clone --recursive https://github.com/DarrenAlex/Impostor
cd Impostor/bot
if [ -z "$password" ]
then
    password=""
else
    password=":${password}"
fi
sudo touch .env
echo "DISCORD_TOKEN=${token}" >> .env
echo "AU_CLIENT_DIR=../client/bin/Debug/netcoreapp3.1" >> .env
echo "DATABASE_URL=postgresql://postgres${password}@localhost:5432/postgres" >> .env
echo "BOT_INVITE_LINK=https://discord.com/api/oauth2/authorize?client_id=${id}&permissions=0&scope=bot" >> .env
npm install
echo "Waiting for the TypeScript compiler to finish... (This might take a while)"
./node_modules/.bin/tsc
echo "TypeScript compiler finished."
pm2 start node dist/index.js
cd ../client
dotnet build
rm ../install.sh
touch ../restart.sh
chmod a+x ../restart.sh
echo "#!/bin/bash" >> ../restart.sh
echo "pm2 kill" >> ../restart.sh
echo "cd bot" >> ../restart.sh
echo "pm2 start node dist/index.js" >> ../restart.sh
echo "cd ../client" >> ../restart.sh
echo "dotnet build" >> ../restart.sh
echo "exit 0;" >> ../restart.sh
cp ../restart.sh ../../restart.sh
echo "=========================================================================================================="
echo "=========================================================================================================="
echo "Installation complete. Run restart.sh to restart the bot if needed. You may remove the install script now."
echo "NOTE: You may ignore all warnings, they aren't important."
exit 0;
