#!/bin/bash
sudo apt update -y && sudo apt upgrade -y

sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt update -y
apt install apt-transport-https -y
sudo apt install openjdk-11-jdk -y
sudo apt install unzip -y
wget -qO - https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch | sudo apt-key add -
echo "deb https://d3g5vo6xdbdb9a.cloudfront.net/apt stable main" | sudo tee -a   /etc/apt/sources.list.d/opendistroforelasticsearch.list
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.8.0-amd64.deb
sudo dpkg -i elasticsearch-oss-7.8.0-amd64.deb
sudo apt-get update -y
sudo apt install opendistroforelasticsearch=1.9.0-1 -y

sleep 5

sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

wget https://github.com/codelibs/fess/releases/download/fess-13.9.0/fess-13.9.0.deb
sudo apt install fess-13.9.0.deb

sudo systemctl enable fess
sudo systemctl start fess
