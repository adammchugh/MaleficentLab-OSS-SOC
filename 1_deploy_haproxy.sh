#!/bin/sh

sudo apt update -y && sudo apt upgrade -y

sudo add-apt-repository ppa:vbernat/haproxy-2.0
sudo apt update -y
sudo apt install haproxy -y

echo "Installation complete. Please refer to HAProxy documentation for configuration of /etc/haproxy/haproxy.cfg"
