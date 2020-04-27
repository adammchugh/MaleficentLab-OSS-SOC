#!/bin/sh

apt remove wazuh-agent -y
apt-get remove --purge wazuh-agent

sudo apt-get install curl apt-transport-https lsb-release gnupg2 -y
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -
echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
apt-get update -y

WAZUH_MANAGER_IP="172.16.0.124"
apt-get install wazuh-agent -y

sed -i "s/^deb/#deb/" /etc/apt/sources.list.d/wazuh.list
apt-get update
