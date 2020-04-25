#!/bin/bash

sudo apt-get update -y
sudo apt-get install curl apt-transport-https lsb-release gnupg2 -y
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -
echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | sudo tee -a /etc/apt/sources.list.d/wazuh.list

sudo apt-get update -y
sudo apt-get install wazuh-manager -y
sudo systemctl status wazuh-manager

curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install nodejs -y
sudo apt-get install wazuh-api -y
sudo systemctl status wazuh-api

echo "wazuh-manager hold" | sudo dpkg --set-selections
echo "wazuh-api hold" | sudo dpkg --set-selections

wget -O filebeat-oss-7.6.2-amd64.deb https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-7.6.2-amd64.deb
sudo dpkg -i filebeat-oss-7.6.2-amd64.deb
