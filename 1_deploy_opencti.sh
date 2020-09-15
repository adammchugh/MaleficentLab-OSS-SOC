#!/bin/bash
sudo apt-get install nodejs npm python3 python3-pip
mkdir /opt/opencti && cd /opt/opencti
wget https://github.com/OpenCTI-Platform/opencti/releases/download/{RELEASE_VERSION}/opencti-release.tar.gz
tar xvfz opencti-release.tar.gz
cd opencti 
cp config/default.json config/production.json

wget https://github.com/OpenCTI-Platform/connectors/archive/{RELEASE_VERSION}.zip 
unzip {RELEASE_VERSION}.zip 
cd connectors-{RELEASE_VERSION}/misp/ 
pip3 install -r requirements.txt 
cp config.yml.sample config.yml
