#!/bin/bash

echo "Choose new hostname:"
read HOSTNAME
sudo hostnamectl set-hostname $HOSTNAME

echo "Choose mode of Elasticnode:"
echo "(1) Single-node"
echo "(2) Master-node"
echo "(3) Co-ordination Node"
echo "(4) Data Node"
echo "(5) Ingest Node"
read NODETYPE

case $NODETYPE in
  1)
    echo "Configuring for Single-node"
    ;;
  2)
    echo "Configuring for Master Node"
    echo -n "Set Cluster-Name: "
    read CLUSTERNAME
    ;;
  3)
    echo "Configuring for Co-ordination Node"
    echo -n "Set Cluster-Name: "
    read CLUSTERNAME
    ;;
  4)
    echo "Configuring for Data Node"
    echo -n "Set Cluster-Name: "
    read CLUSTERNAME
    ;;
  5)
    echo "Configuring for Ingest Node"
    echo -n "Set Cluster-Name: "
    read CLUSTERNAME
    ;;
  *)
    echo "Option unknown"
    exit
    ;;
esac

echo "Deploying Elasticsearch. Node Type: $NODETYPE"

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt update -y
apt install apt-transport-https -y
sudo apt install openjdk-11-jdk -y
sudo apt install unzip -y
wget -qO - https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch | sudo apt-key add -
echo "deb https://d3g5vo6xdbdb9a.cloudfront.net/apt stable main" | sudo tee -a   /etc/apt/sources.list.d/opendistroforelasticsearch.list
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.7.0-amd64.deb
sudo dpkg -i elasticsearch-oss-7.7.0-amd64.deb
sudo apt-get update -y
sudo apt install opendistroforelasticsearch -y

case $NODETYPE in
  1)
    # sudo sh -c 'echo cluster.name: $CLUSTERNAME >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c 'network.host: [_local_] >> /etc/elasticsearch/elasticsearch.yml'
    ;;
  2)
    sudo sh -c 'echo cluster.name: $CLUSTERNAME >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c 'echo network.host: [_site_] >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c 'discovery.seed_hosts: ["<private IP of odfe-d1>", "<private IP of odfe-d2>", "<private IP of odfe-c1>"] >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c '# node.attr.zone: zoneIdentifier >> /etc/elasticsearch/elasticsearch.yml'
    ;;
  3)
    sudo sh -c 'echo cluster.name: $CLUSTERNAME >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c 'echo network.host: [_site_] >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c '# node.attr.zone: zoneIdentifier >> /etc/elasticsearch/elasticsearch.yml'
    ;;
  4)
    sudo sh -c 'echo cluster.name: $CLUSTERNAME >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c 'echo network.host: [_site_] >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c '# node.attr.zone: zoneIdentifier >> /etc/elasticsearch/elasticsearch.yml'
    ;;
  5)
    sudo sh -c 'echo cluster.name: $CLUSTERNAME >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c 'echo network.host: [_site_] >> /etc/elasticsearch/elasticsearch.yml'
    sudo sh -c '# node.attr.zone: zoneIdentifier >> /etc/elasticsearch/elasticsearch.yml'
    ;;
esac

echo "Installation of Open Distro Elasticsearch is complete."

sudo reboot now
