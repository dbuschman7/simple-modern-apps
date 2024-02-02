#!/bin/sh 
set -e

version="latest"

. ../../common/base_functions.sh

export CGO_ENABLED=0 
export GOOS=linux 
export GOARCH=amd64 

# build the lambda function
go build -o bootstrap  -ldflags="-s -w" main.go

echo "********************************************************************"
ls -h bootstrap
echo "********************************************************************"

packageDockerImage Dockerfile lambda-go $version

# Dump the image
echo "********************************************************************"
docker images | grep lambda-rust
echo "********************************************************************"


