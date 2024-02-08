#! /bin/sh 
set -e
APP_NAME="run-stats-service"
. ../common/base_functions.sh

# Force our script to run in the same directory as the script
scriptLocalDir $0

version="$( cat version.txt )"

BASE_DIR=$(pwd)

# Build the go binary
go mod tidy 
go build -o target/$APP_NAME run-stats-service.go

chmod +x target/$APP_NAME

echo "*********************************************"
ls -la target
echo "*********************************************"

packageDockerImage Dockerfile $APP_NAME $version

# Dump the image
echo "********************************************************************"
docker images | grep $APP_NAME
echo "********************************************************************"

