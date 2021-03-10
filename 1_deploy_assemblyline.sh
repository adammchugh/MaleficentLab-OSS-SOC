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

# git clone https://github.com/CybercentreCanada/assemblyline-docker-compose.git
git clone -b b4970d7262 https://github.com/CybercentreCanada/assemblyline-docker-compose.git

cd assemblyline-docker-compose/full_appliance

openssl req -nodes -x509 -newkey rsa:4096 -keyout ./config/nginx.key -out ./config/nginx.crt -days 365 -subj "/C=CA/ST=Ontario/L=Ottawa/O=CCCS/CN=$fqdn_string"

PASSWORD_FILESTORE=$(openssl rand -base64 12)
sed -i "s/password_123/$PASSWORD_FILESTORE/g" ./.env

PASSWORD_ELASTIC=$(openssl rand -base64 12)
sed -i "s/password_456/$PASSWORD_ELASTIC/g" ./.env

PASSWORD_SERVICE=$(openssl rand -base64 12)
sed -i "s/password_789/$PASSWORD_SERVICE/g" ./.env

PASSWORD_INITIAL=$(openssl rand -base64 12)
sed -i "s/PASSWORD = 'admin'/PASSWORD = '$PASSWORD_INITIAL'/g" ./config/bootstrap.py

sed -i "s/assemblyline.local/$fqdn_string/g" ./.env

echo "FILESTORE PASSWORD: ${PASSWORD_FILESTORE} \n"
echo "ELASTIC PASSWORD: ${PASSWORD_ELASTIC} \n"
echo "SERVICE PASSWORD: ${PASSWORD_SERVICE} \n"
echo "INITIAL PASSWORD: ${PASSWORD_INITIAL} \n"
echo "SERVICE HOSTNAME: ${fqdn_string} \n"

echo "FILESTORE PASSWORD: ${PASSWORD_FILESTORE} \n" >> ./.credentials.txt
echo "ELASTIC PASSWORD: ${PASSWORD_ELASTIC} \n" >> ./.credentials.txt
echo "SERVICE PASSWORD: ${PASSWORD_SERVICE} \n" >> ./.credentials.txt
echo "INITIAL PASSWORD: ${PASSWORD_INITIAL} \n" >> ./.credentials.txt
echo "SERVICE HOSTNAME: ${fqdn_string} \n" >> ./.credentials.txt

echo "sudo docker-compose pull"
echo "sudo docker-compose up -d"

echo "sudo docker-compose -f bootstrap-compose.yaml pull "
echo "sudo docker-compose -f bootstrap-compose.yaml up -d "
