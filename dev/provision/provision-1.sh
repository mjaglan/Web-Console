#!/bin/bash

set -x

echo "************************* $0 running *************************"

# Run distribution update
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get -f install

# add vagrant user to vboxsf group
sudo adduser vagrant vboxsf

# Check VBoxGuestAdditions version -
echo VBoxGuestAdditions $(lsmod | grep -io vboxguest | xargs modinfo | grep -iw version)

set +x
