#!/bin/bash
sudo apt update -y && sudo apt upgrade -y

wget -O splunk-8.0.3-a6754d8441bf-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.3&product=splunk&filename=splunk-8.0.3-a6754d8441bf-linux-2.6-amd64.deb&wget=true'
sudo dpkg -i splunk-8.0.3-a6754d8441bf-linux-2.6-amd64.deb

sudo /opt/splunk/bin/splunk enable boot-start

sudo systemctl start splunk
