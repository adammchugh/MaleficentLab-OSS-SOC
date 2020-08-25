#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get update -y
sudo apt-get install certbot python-certbot-apache -y
sudo apt install python3-pip -y
sudo apt-get install mysql-client  -y

curl https://raw.githubusercontent.com/MISP/MISP/2.4/INSTALL/INSTALL.sh -o misp_install.sh
chmod +x misp_install.sh
./misp_install.sh -A

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

sudo systemctl start apache2
sudo systemctl enable apache2
