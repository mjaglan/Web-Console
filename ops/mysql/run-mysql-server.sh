#!/bin/bash

# REFERENCE
# https://hub.docker.com/r/library/mysql/
# https://github.com/docker-library/mysql/

# variables
IMG_NAME="mysql:5.6"
BASE_HOSTNAME="testbed"
NETWORK_NAME=$BASE_HOSTNAME
MYSQL_HOSTNAME="$BASE_HOSTNAME-mysql"

# if desired, clean up all images and containers
if [[ "$1" == "rmi" ]] ; then
	docker stop $(docker ps -a -q)
	docker rm -v $(docker ps -a -q)
	docker rmi $(docker images -q)
else
	docker stop $MYSQL_HOSTNAME
	docker rm -v $MYSQL_HOSTNAME
	sleep 5s
fi

# pull docker image
docker pull $IMG_NAME

# Default docker network name is 'bridge', driver is 'bridge', scope is 'local'
# Create a new network with any name, and keep 'bridge' driver for 'local' scope.
NET_QUERY=$(docker network ls | grep -i $NETWORK_NAME)
if [ -z "$NET_QUERY" ]; then
	echo "Create network >>> $NETWORK_NAME"
	docker network create --driver=bridge $NETWORK_NAME
fi

# Reference: https://stackoverflow.com/a/630387
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  echo "for some reason, the path is not accessible to the script"
  exit 1  # fail
fi

MYSQL_PWD=$(cat $MY_PATH/.credentials)
docker run --name  "$MYSQL_HOSTNAME" -h "$MYSQL_HOSTNAME" --net=$NETWORK_NAME \
        -e MYSQL_ROOT_PASSWORD=$MYSQL_PWD \
        -v  $MY_PATH/sql:/docker-entrypoint-initdb.d:rw \
        -d "$IMG_NAME"

# see active docker containers
docker ps
