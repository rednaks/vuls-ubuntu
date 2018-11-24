#!/bin/bash

VULS_UBUNTU_HOME=$PWD

echo "Installing dependencies ..."
sudo apt install git gcc make curl

echo "Installing go-lang ..."
GO_PKG="go1.10.4.linux-amd64.tar.gz"
curl https://dl.google.com/go/$GO_PKG --output /tmp/$GO_PKG
sudo tar -C /usr/local/ -xzf /tmp/$GO_PKG
mkdir -p $HOME/go

echo -e "export GOROOT=/usr/local/go\n\
export GOPATH=$HOME/go\n\
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" | sudo tee /etc/profile.d/goenv.sh

source /etc/profile.d/goenv.sh

echo "Creating log directories:"
sudo mkdir -p /var/log/vuls /var/log/gost /var/log/go-exploitdb
sudo chown $USER:$USER -R /var/log/vuls /var/log/gost /var/log/go-exploitdb
GO_SRC=$GOPATH/src/github.com/
mkdir -p $GO_SRC
cd $GO_SRC

echo "Deploying go-cve-dictionary..."
git clone https://github.com/kotakanbe/go-cve-dictionary.git
cd $GO_SRC/go-cve-dictionary
make install
cd ..

echo "Deploying goval-dictionary..."
git clone https://github.com/kotakanbe/goval-dictionary.git
cd goval-dictionary
make install
cd ..

echo "Deploying gost"
git clone https://github.com/knqyf263/gost.git
cd gost
make install
cd ..

echo "Deploying go-exploitdb"
git clone https://github.com/mozqnet/go-exploitdb.git
cd go-exploitdb
make install
cd ..


echo "Deploy Vuls:"
git clone https://github.com/future-architect/vuls.git
cd vuls
make install
cd $VULS_UBUNTU_HOME

