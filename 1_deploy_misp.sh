#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get update -y
sudo apt-get install certbot python-certbot-apache -y
sudo apt install python3-pip -y

read -p "Enter the hostname for this MISP instance: " misphostname
sudo certbot certonly -d '$staticip' --server https://acme-v02.api.letsencrypt.org/directory



sudo apt-get install mysql-client  -y

curl -fsSL https://raw.githubusercontent.com/MISP/MISP/2.4/INSTALL/INSTALL.sh | bash -s -- -c -A

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

sudo cp /etc/ssl/private/misp.local.crt old.misp.local.crt
sudo cp /etc/ssl/private/misp.local.key old.misp.local.key

sudo cp /etc/letsencrypt/live/misp.example.com/privkey.pem /etc/ssl/private/misp.local.key
sudo cp /etc/letsencrypt/live/misp.example.com/cert.pem /etc/ssl/private/misp.local.crt

sudo systemctl restart apache2
