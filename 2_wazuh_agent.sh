#!/bin/sh

apt remove wazuh-agent -y
apt-get remove --purge wazuh-agent
rm -fr /etc/apt/sources.list.d/wazuh.list

sudo apt-get install curl apt-transport-https lsb-release gnupg2 -y
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -
echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
apt-get update -y

systemctl enable wazuh-agent
