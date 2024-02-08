#! /bin/sh 
set -ex 

APP_NAME="config-service"


. ../common/base_functions.sh

# Force our script to run in the same directory as the script
scriptLocalDir $0

version="$( cat version.txt )"

BASE_DIR=$(pwd)

# Generate the proto file
mkdir -p config 


# Generate the proto file
protoc   --go_out=config  --go_opt=paths=source_relative \
    --go-grpc_out=config  --go-grpc_opt=paths=source_relative \
    config-service.proto

# Build the go binary
go get google.golang.org/grpc
go mod tidy 
go build -o target/$APP_NAME

chmod +x target/$APP_NAME

echo "*********************************************"
ls -la target
echo "*********************************************"

packageDockerImage Dockerfile $APP_NAME $version

# Dump the image
echo "********************************************************************"
docker images | grep $APP_NAME
echo "********************************************************************"

