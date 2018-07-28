#!/bin/bash

# variables
IMG_NAME="mjaglan/expressnode"
HOST_NAME="testbed"
NETWORK_NAME=$HOST_NAME

# if desired, clean up all images and containers
if [[ "$1" == "rmi" ]] ; then
	echo "RUN THIS:"
	echo ". ./ops/mysql/run-mysql-server.sh rmi"
	exit 0
else
	# clean up containers
	docker stop $HOST_NAME
	docker rm -v $HOST_NAME
fi

# Reference: https://stackoverflow.com/a/630387
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

# build the Dockerfile
docker build  -t "$IMG_NAME" "$MY_PATH"

# Default docker network name is 'bridge', driver is 'bridge', scope is 'local'
# Create a new network with any name, and keep 'bridge' driver for 'local' scope.
NET_QUERY=$(docker network ls | grep -i $NETWORK_NAME)
if [ -z "$NET_QUERY" ]; then
	echo "Create network >>> $NETWORK_NAME"
	docker network create --driver=bridge $NETWORK_NAME
fi

# start container
MY_PATH="$MY_PATH/../../src"
docker run --name "$HOST_NAME" -h "$HOST_NAME" --net=$NETWORK_NAME \
		-v  $MY_PATH:/tmp/app:rw \
		-p  12000:3000 \
		-itd "$IMG_NAME"

# see active docker containers
docker ps

# start application service
MY_CMD="/tmp/app/init.sh"
docker exec -it $HOST_NAME $MY_CMD

# attach to the container
docker attach "$HOST_NAME"
