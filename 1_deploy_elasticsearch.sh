#!/bin/bash

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt update -y
apt install apt-transport-https -y
sudo apt install openjdk-11-jdk -y
sudo apt install unzip -y
wget -qO - https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch | sudo apt-key add -
echo "deb https://d3g5vo6xdbdb9a.cloudfront.net/apt stable main" | sudo tee -a   /etc/apt/sources.list.d/opendistroforelasticsearch.list
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.6.1-amd64.deb
sudo dpkg -i elasticsearch-oss-7.6.1-amd64.deb
sudo apt-get update -y
sudo apt install opendistroforelasticsearch -y

read -p 'Define cluster name: ' clustername
sed -i 's/#cluster.name/cluster.name/g' /etc/elasticsearch/elasticsearch.yml
sed -i 's/: my-application/: $clustername/g' /etc/elasticsearch/elasticsearch.yml

read -p 'Define node name: ' nodename
sed -i 's/#node.name:/node.name:/g' /etc/elasticsearch/elasticsearch.yml
sed -i 's/: node-1/: $nodename/g' /etc/elasticsearch/elasticsearch.yml

echo "\nCurrent addresses available on host: \n"
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
read -p 'Define network address: ' networkhost
sed -i 's/#network.host: 192.168.0.1/network.host: $networkhost/g' /etc/elasticsearch/elasticsearch.yml

# sed -i 's/#discovery.seed_hosts: ["host1", "host2"]/discovery.seed_hosts: ["127.0.0.1", "127.0.0.1"]/g' /etc/elasticsearch/elasticsearch.yml
# sed -i 's/#cluster.initial_master_nodes: ["node-1", "node-2"]/cluster.initial_master_nodes: ["127.0.0.1", "127.0.0.1"]/g' /etc/elasticsearch/elasticsearch.yml

echo "Update /etc/elasticsearch/elasticsearch.yml if this node is to be used within a cluster.\n"
echo "Uncomment and update discovery.seed_hosts: to include each node within the cluster.\n"
echo "Uncomment and update cluster.initial_master_nodes: to include which node is considered a master. \n"

sudo systemctl status elasticsearch
sudo systemctl enable elasticsearch

echo "Elasticsearch Service has been enabled. Recommend rebooting prior to be being placed into service.\n"
