#!/bin/bash

cd /opt
wget https://curl.se/download/curl-7.86.0.tar.gz
tar -xvzf curl-7.86.0.tar.gz
rm curl-7.86.0.tar.gz
sudo apt install libssh2-1-dev libssl-dev
cd curl-7.86.0/
./configure --with-ssl --with-libssh2
sudo make
sudo make install