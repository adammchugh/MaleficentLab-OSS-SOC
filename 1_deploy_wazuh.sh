#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install curl apt-transport-https lsb-release -y

CODENAME=$(lsb_release -cs)
echo "deb https://packages.wazuh.com/apt $CODENAME main" | sudo tee /etc/apt/sources.list.d/wazuh.list
sudo apt update -y
sudo apt-get install wazuh-manager -y

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt-get install wazuh-api -y

curl -s https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-5.x.list
apt-get update -y
apt-get install filebeat=5.6.5 -y
curl -so /etc/filebeat/filebeat.yml https://raw.githubusercontent.com/wazuh/wazuh/2.1/extensions/filebeat/filebeat.yml

echo "Edit the file /etc/filebeat/filebeat.yml and replace ELASTIC_SERVER_IP with the IP address or the hostname of the Elastic Stack server \n"
