#!/bin/bash

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt update -y
apt install apt-transport-https -y
sudo apt install openjdk-11-jdk -y
sudo apt install unzip -y
wget -qO - https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch | sudo apt-key add -
echo "deb https://d3g5vo6xdbdb9a.cloudfront.net/apt stable main" | sudo tee -a   /etc/apt/sources.list.d/opendistroforelasticsearch.list
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.7.0-amd64.deb
sudo dpkg -i elasticsearch-oss-7.6.1-amd64.deb
sudo apt-get update -y
sudo apt install opendistroforelasticsearch -y

echo "Update /etc/elasticsearch/elasticsearch.yml if this node is to be used within a cluster.\n"
echo "Uncomment and update discovery.seed_hosts: to include each node within the cluster.\n"
echo "Uncomment and update cluster.initial_master_nodes: to include which node is considered a master. \n"
