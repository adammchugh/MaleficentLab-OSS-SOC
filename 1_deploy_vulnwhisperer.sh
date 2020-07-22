#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt-get install  zlib1g-dev libxml2-dev libxslt1-dev git python-pip -y
git clone https://github.com/HASecuritySolutions/VulnWhisperer /opt/
pip install -r /opt/VulnWhisperer/requirements.txt
cd /opt/VulnWhisperer/
python setup.py install
