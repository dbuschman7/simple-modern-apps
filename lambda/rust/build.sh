#!/bin/sh 
set -e

version="latest"

. ../../common/base_functions.sh

# Build the Rust Lambda function
cargo lambda build --release

echo "********************************************************************"
ls -lh target/lambda/hello/bootstrap 
echo "********************************************************************"

# Create a Docker image for the Rust Lambda function
packageDockerImage Dockerfile lambda-rust $version

# Dump the image
echo "********************************************************************"
docker images | grep lambda-rust
echo "********************************************************************"
