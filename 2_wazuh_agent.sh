#!/bin/sh

sudo apt remove wazuh-agent -y
sudo apt-get remove --purge wazuh-agent -y
sudo rm -fr /etc/apt/sources.list.d/wazuh.list

sudo apt-get install curl apt-transport-https lsb-release gnupg2 -y
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -
echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
sudo apt-get update -y

sudo apt install wazuh-agent -y

read -p 'Wuzah Manager IP: ' wazuhmanagerip

sudo sed -i "s/MANAGER_IP/$wazuhmanagerip/g" /var/ossec/etc/ossec.conf
