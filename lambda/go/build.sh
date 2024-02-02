#!/bin/sh 
set -ex
. ../../common/base_functions.sh

# Force our script to run in the same directory as the script
scriptLocalDir $0

version="$( cat version.txt )"

mkdir -p target

export CGO_ENABLED=0 
export GOOS=linux 
export GOARCH=amd64 

# build the lambda function
go build -o target/bootstrap  -ldflags="-s -w" main.go

echo "********************************************************************"
ls -h target/bootstrap
echo "********************************************************************"

packageDockerImage Dockerfile lambda-go $version

# Dump the image
echo "********************************************************************"
docker images | grep lambda-go
echo "********************************************************************"


