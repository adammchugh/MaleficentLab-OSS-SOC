#!/bin/sh

sudo apt update -y && sudo apt upgrade -y
sudo apt-get install -y openjdk-8-jre-headless

echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

curl -fsSL https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

sudo apt update -y
sudo apt install cassandra -y

sleep 10

sudo cqlsh localhost 9042 -e "UPDATE system.local SET cluster_name = 'thp' where key='local';"

sleep 10

sudo nodetool flush

curl https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY | sudo apt-key add -
echo 'deb https://deb.thehive-project.org beta main' | sudo tee -a /etc/apt/sources.list.d/thehive-project.list
sudo apt-get update
sudo apt-get install thehive4

sudo mkdir -p /opt/thp_data/files/thehive
chown -R thehive:thehive /opt/thp_data/files/thehive
