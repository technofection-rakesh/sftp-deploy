#!/bin/bash

export CPPFLAGS=-I/usr/local/include
export LDFLAGS="-L/usr/local/lib -Wl,-rpath,/usr/local/lib"
export LIBS="-ldl"

sudo sed -i -e "s/# deb-src /deb-src /g" /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y build-essential debhelper libssh-dev

cd /opt/

# Fetch cURL source code
sudo apt-get source curl
sudo apt-get build-dep -y curl
cd curl-*/debian/ && sudo sed -i -e "s@CONFIGURE_ARGS += --without-libssh2@CONFIGURE_ARGS += --with-libssh2@g" rules
cd curl-*/ && sudo dpkg-buildpackage -uc -us -b

# Install rebuilding packages
sudo dpkg -i curl_*.deb
sudo dpkg -i libcurl3-*.deb
sudo dpkg -i libcurl3-gnutls_*.deb
sudo dpkg -i libcurl4-gnutls-dev_7.58.0-2ubuntu3.8_amd64.deb libcurl4_7.58.0-2ubuntu3.8_amd64.deb