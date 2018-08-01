#!/bin/bash

set -x

echo "************************* $0 running *************************"

apt-get -qq -y update
apt-get -qq -y dist-upgrade

# https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce

# https://docs.docker.com/install/linux/linux-postinstall/
sudo groupadd docker
set +x
