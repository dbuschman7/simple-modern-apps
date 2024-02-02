#!/bin/sh 
set -e

. ../../common/base_functions.sh

# Force our script to run in the same directory as the script
scriptLocalDir $0

version="$( cat version.txt )"

# ############################
# Make the artifact
# ############################

export FALLBACK_EXECUTOR_VERBOSE=true 
scala-cli clean . 
scala-cli package --power --scala 2.13 \
	--native-image --graalvm-version 22.3.3 \
    LambdaMain.scala \
	-v -f -o target/bootstrap -f \
	-- --enable-url-protocols=http --no-fallback \
     \
	-H:+ReportExceptionStackTraces


echo "********************************************************************"
ls -lh target/bootstrap
echo "********************************************************************"

packageDockerImage Dockerfile lambda-scala $version

# Dump the image
echo "********************************************************************"
docker images | grep lambda-scala
echo "********************************************************************"


