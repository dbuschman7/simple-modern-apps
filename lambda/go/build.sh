#!/bin/sh 
set -ex
source  ../../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script

source ./.env

# Begin the build
mkdir -p target

export CGO_ENABLED=0 
export GOOS=linux 
export GOARCH=amd64 

# build the lambda function
go build -o target/bootstrap  -ldflags="-s -w" main.go

echo "********************************************************************"
ls -h target/bootstrap
echo "********************************************************************"

packageDockerImage Dockerfile $APP_NAME $APP_VERSION

# Dump the image
echo "********************************************************************"
docker images | grep $APP_NAME 
echo "********************************************************************"


