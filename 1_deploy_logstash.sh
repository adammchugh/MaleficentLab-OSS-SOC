#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install openjdk-8-jre-headless -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update -y && sudo apt-get install logstash -y
