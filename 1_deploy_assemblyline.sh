#!/bin/bash

echo What is the FQDN of the AssemblyLine appliance?:
read fqdn_string

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get update -y
sudo apt-get install certbot -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Test Docker installation
sudo docker run hello-world

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Test docker-compose installation
docker-compose --version

git clone https://github.com/CybercentreCanada/assemblyline-docker-compose.git

cd assemblyline-docker-compose/full_appliance

# openssl req -nodes -x509 -newkey rsa:4096 -keyout ./config/nginx.key -out ./config/nginx.crt -days 365 -subj "/C=CA/ST=Ontario/L=Ottawa/O=CCCS/CN=assemblyline.local"
sudo certbot certonly --standalone --preferred-challenges http -d $fqdn_string
sudo cp /etc/letsencrypt/live/$fqdn_string/privkey.pem ./config/nginx.crt
sudo cp /etc/letsencrypt/live/$fqdn_string/cert.pem ./config/nginx.key

echo "Set passwords and paths in ./.env and ./config/bootstrap.py"

echo "sudo docker-compose pull"
echo "sudo docker-compose up -d"

echo "sudo docker-compose -f bootstrap-compose.yaml pull "
echo "sudo docker-compose -f bootstrap-compose.yaml up -d "
