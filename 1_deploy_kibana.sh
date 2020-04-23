#!/bin/bash

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt update -y
apt install apt-transport-https -y
sudo apt install openjdk-11-jdk -y
sudo apt install unzip -y
wget -qO - https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch | sudo apt-key add -
echo "deb https://d3g5vo6xdbdb9a.cloudfront.net/apt stable main" | sudo tee -a   /etc/apt/sources.list.d/opendistroforelasticsearch.list
sudo apt-get update -y
sudo apt install opendistroforelasticsearch-kibana -y

read -p 'Define Elasticsearch host: ' eshost
sed -i 's/https://localhost:9200/https://$eshost:9200/g' /etc/kibana/kibana.yml
