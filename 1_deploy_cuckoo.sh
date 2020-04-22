#!/bin/sh

sudo apt update -y && sudo apt upgrade -y

sudo apt install python python-pip python-dev libffi-dev libssl-dev  -y
sudo apt install virtualbox virtualbox-guest-additions-iso virtualbox-dkms -y
sudo apt install libjpeg-dev zlib1g-dev swig ssdeep tcpdump mongodb volatility -y
sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

