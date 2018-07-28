#!/bin/bash

# enable exit on error
set -e

# move to app directory
cd $PROJECT

# install express js
npm install -g express-generator

PNAME="express_app"
if [[ ! -d "$PROJECT/$PNAME" ]]; then
    # create express project
	express -c stylus $PNAME
fi

# go to project setup
cd "$PROJECT/$PNAME"

# npm install nodemon
npm install --no-bin-links
npm install -g nodemon

# list all processes
ps -eu

# check if .env exists
DOTENV_FILE="$PROJECT/$PNAME/.env"
if [ -f "$DOTENV_FILE" ]
then
	echo "EXISTS: $DOTENV_FILE"
else
	echo "CREATING: $DOTENV_FILE"
	> $DOTENV_FILE
	echo "DB_HOST=" >> $DOTENV_FILE
	echo "DB_USER=" >> $DOTENV_FILE
	echo "DB_PASS=" >> $DOTENV_FILE
	echo "MANUALLY EDIT: $DOTENV_FILE"
fi

# disable exit on error
set +e

# npm start
DEBUG=$PNAME nodemon npm start