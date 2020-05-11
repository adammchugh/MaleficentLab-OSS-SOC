#!/bin/sh

sudo apt update -y && sudo apt upgrade -y
sudo apt-get install git -y
cd /opt/
sudo git clone https://github.com/threatstream/mhn.git
cd mhn/
sudo ./install.sh

sudo /etc/init.d/nginx status
sudo /etc/init.d/supervisor status

cd /opt/mhn/scripts
sudo ./disable_collector.sh

