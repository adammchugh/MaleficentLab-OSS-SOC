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

