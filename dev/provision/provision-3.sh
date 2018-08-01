#!/bin/bash

set -x

echo "************************* $0 running *************************"

sudo usermod -aG docker "vagrant"

echo "Test docker is running properly."
TEST_IMG="hello-world"
TEST_CON="$TEST_IMG"
docker pull "$TEST_IMG"
docker stop "$TEST_CON"
docker rm -v "$TEST_CON"
sleep 5s
docker run --name  "$TEST_CON" \
            -h     "$TEST_CON" \
            -d     "$TEST_IMG"

set +x
