#!/bin/sh

sudo apt update -y && sudo apt upgrade -y

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-8-jre-headless

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key D88E42B4
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt install apt-transport-https -y
sudo apt update -y && sudo apt install elasticsearch -y

sed -i '#cluster.name: my-application/cluster.name: cortex/g' /etc/elasticsearch/elasticsearch.yml
sed -i '#node.name: node-1/node.name: node-1/g' /etc/elasticsearch/elasticsearch.yml
sed -i '#network.host: 192.168.0.1/network.host: 0.0.0.0/g' /etc/elasticsearch/elasticsearch.yml

sudo systemctl enable elasticsearch && sudo systemctl start elasticsearch

echo 'deb https://dl.bintray.com/thehive-project/debian-stable any main' | sudo tee -a /etc/apt/sources.list.d/thehive-project.list
sudo apt-key adv --keyserver hkp://pgp.mit.edu --recv-key 562CBC1C
curl https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY | sudo apt-key add -
sudo apt-get update -y && sudo apt install cortex -y

sudo apt-get install -y --no-install-recommends python-pip python2.7-dev python3-pip python3-dev ssdeep libfuzzy-dev libfuzzy2 libimage-exiftool-perl libmagic1 build-essential git libssl-dev
sudo pip install -U setuptools && sudo pip3 install -U setuptools
sudo pip install wheel
sudo pip3 install wheel

sudo git clone https://github.com/TheHive-Project/Cortex-Analyzers /opt/Cortex-Analyzers/
cd /opt/
for I in $(find Cortex-Analyzers -name 'requirements.txt'); do sudo -H pip install -r $I; done
for I in $(find Cortex-Analyzers -name 'requirements.txt'); do sudo -H pip3 install -r $I; done

read -p 'Define ES address: ' esaddress
sed -i 's/uri = "http://127.0.0.1:9200"/uri = "http://$esaddress:9200"/g' /etc/cortex/application.conf

sed -i 's/"https://dl.bintray.com/thehive-project/cortexneurons/analyzers.json"/"/opt/Cortex-Analyzers/analyzers/"/g' /etc/cortex/application.conf
sed -i 's/"https://dl.bintray.com/thehive-project/cortexneurons/responders.json"/"/opt/Cortex-Analyzers/responders/"/g' /etc/cortex/application.conf

SECRETKEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
sed -i 's/#play.http.secret.key="***CHANGEME***"/play.http.secret.key="$SECRETKEY"/g' /etc/cortex/application.conf

sudo systemctl enable cortex && sudo systemctl start cortex && sudo systemctl status cortex
