#!/bin/sh 
set -e

. ../../common/base_functions.sh

# Force our script to run in the same directory as the script
scriptLocalDir $0

version="$( cat version.txt )"


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
