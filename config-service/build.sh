#! /bin/sh 
set -ex 

. ../common/base_functions.sh

# Force our script to run in the same directory as the script
scriptLocalDir $0

BASE_DIR=$(pwd)


cd proto

protoc  --go_out=.   --go_opt=paths=source_relative \
    --go-grpc_out=.  --go-grpc_opt=paths=source_relative \
    config-service.proto
