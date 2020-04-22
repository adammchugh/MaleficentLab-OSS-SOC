#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install mysql-client  -y
curl https://raw.githubusercontent.com/MISP/MISP/2.4/INSTALL/INSTALL.sh -o misp_install.sh
chmod +x misp_install.sh
./misp_install.sh -A
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

echo "Browse to https://<FQDN of MISP>/users/login \n"
echo "Username:  admin@admin.test \n"
echo "Password: admin \n"
