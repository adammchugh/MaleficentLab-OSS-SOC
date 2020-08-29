#!/bin/bash
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt install -y cmake pkg-config libglib2.0-dev libgpgme11-dev libgnutls28-dev uuid-dev libssh-gcrypt-dev \
libldap2-dev doxygen graphviz libradcli-dev libhiredis-dev libpcap-dev bison libksba-dev libsnmp-dev \
gcc-mingw-w64 heimdal-dev libpopt-dev xmltoman redis-server xsltproc libical2-dev postgresql \
postgresql-contrib postgresql-server-dev-all gnutls-bin nmap rpm nsis curl wget fakeroot gnupg \
sshpass socat snmp smbclient libmicrohttpd-dev libxml2-dev python-polib gettext \
python3-paramiko python3-lxml python3-defusedxml python3-pip python3-psutil virtualenv ;\
sudo apt install -y texlive-latex-extra --no-install-recommends
sudo apt install -y texlive-fonts-recommended
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt -y install yarn

cp /etc/environment ~/environment.bak
sudo sed -i 's|PATH="|PATH="/opt/gvm/bin:/opt/gvm/sbin:/opt/gvm/.local/bin:|g' /etc/environment ;\
sudo bash -c 'cat << EOF > /etc/ld.so.conf.d/gvm.conf
# gmv libs location
/opt/gvm/lib
EOF'

sudo mkdir /opt/gvm ;\
sudo adduser gvm --disabled-password --home /opt/gvm/ --no-create-home --gecos '' ;\
sudo usermod -aG redis gvm  # This is for ospd-openvas can connect to redis.sock.. If you have a better idea here, pls write in the comments :) ;\
sudo chown gvm:gvm /opt/gvm/ ;\
sudo su - gvm

mkdir src ;\
cd src ;\
export PKG_CONFIG_PATH=/opt/gvm/lib/pkgconfig:$PKG_CONFIG_PATH

wget -O gvm-libs-11.0.0.tar.gz  https://github.com/greenbone/gvm-libs/archive/v11.0.0.tar.gz ;\
wget -O openvas-7.0.0.tar.gz https://github.com/greenbone/openvas/archive/v7.0.0.tar.gz ;\
wget -O gvmd-9.0.0.tar.gz https://github.com/greenbone/gvmd/archive/v9.0.0.tar.gz ;\
wget -O openvas-smb-1.0.5.tar.gz https://github.com/greenbone/openvas-smb/archive/v1.0.5.tar.gz ;\
wget -O gsa-9.0.0.tar.gz https://github.com/greenbone/gsa/archive/v9.0.0.tar.gz ;\
wget -O ospd-openvas-1.0.0.tar.gz https://github.com/greenbone/ospd-openvas/archive/v1.0.0.tar.gz ;\
wget -O ospd-2.0.0.tar.gz https://github.com/greenbone/ospd/archive/v2.0.0.tar.gz

find . -name \*.gz -exec tar zxvfp {} \;

cd gvm-libs-11.0.0 ;\
 export PKG_CONFIG_PATH=/opt/gvm/lib/pkgconfig:$PKG_CONFIG_PATH ;\
 mkdir build ;\
 cd build ;\
 cmake -DCMAKE_INSTALL_PREFIX=/opt/gvm .. ;\
 make ;\
 make doc ;\
 make install ;\
 cd /opt/gvm/src
 
 cd openvas-smb-1.0.5 ;\
 export PKG_CONFIG_PATH=/opt/gvm/lib/pkgconfig:$PKG_CONFIG_PATH ;\
 mkdir build ;\
 cd build/ ;\
 cmake -DCMAKE_INSTALL_PREFIX=/opt/gvm .. ;\
 make ;\
 make install ;\
 cd /opt/gvm/src
 
 cd openvas-7.0.0 ;\
 export PKG_CONFIG_PATH=/opt/gvm/lib/pkgconfig:$PKG_CONFIG_PATH ;\
 mkdir build ;\
 cd build/ ;\
 cmake -DCMAKE_INSTALL_PREFIX=/opt/gvm .. ;\
 make ;\
 make doc ;\
 make install ;\
 cd /opt/gvm/src
 
