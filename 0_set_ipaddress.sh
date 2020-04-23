#!/bin/bash
#
# Creates a backup
cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bk_`date +%Y%m%d%H%M`
# Changes dhcp from 'yes' to 'no'
sed -i "s/dhcp4: yes/dhcp4: no/g" /etc/netplan/01-netcfg.yaml
# Retrieves the NIC information
nic=`ifconfig | awk 'NR==1{print $1}'`
# Ask for input on network configuration
ifconfig
read -p "Enter the static IP of the server in CIDR notation: " staticip 
read -p "Enter the IP of your gateway: " gatewayip
read -p "Enter the IP of preferred nameservers (seperated by a coma if more than one): " nameserversip
echo
cat > /etc/netplan/01-netcfg.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $nic
      addresses:
        - $staticip
      gateway4: $gatewayip
      nameservers:
          addresses: [$nameserversip]
EOF
sudo netplan apply
echo "==========================="
echo
