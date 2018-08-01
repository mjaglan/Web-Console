#!/bin/bash

# Vagrant box name
BOX_NAME="Vagrant-Ubuntu-16.04"

# Prune invalid vagrant-environment entries and old versions of installed boxes
vagrant global-status --prune
vagrant box prune --force

# if desired, destroy the vm and all boxes
if [[ "$1" == "rmi" ]] ; then
	echo "REMOVING VAGRANT BOX(es)"
	vagrant destroy -f "$BOX_NAME"
	vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
else
	# if exists, halt the vagrant box
	echo "VAGRANT HALT"
	vagrant halt
fi

TIMES="5s"
echo "WAIT FOR $TIMES"
sleep $TIMES

echo "VAGRANT UP"
vagrant up

echo "VAGRANT PROVISION"
vagrant provision

echo "VAGRANT SSH"
vagrant ssh
