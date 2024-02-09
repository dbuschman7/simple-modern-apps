# Config Service

## Setup

* define the gRPC schema for making calls
* stand up server
* return dummy data for now
* [version.txt](./version.txt) contains the active image version tag
* [Dockerfile](./Dockerfile) assembles the image 

## Steps

* [build.sh](./build.sh) -- cleanup, code gne, build and package
* [run-bare-metal.sh](./run-bare-metal.sh) -- run local on laptop
* TODO - run as k8s DaemonSet with local network only service
* TODO - include in helm chart and docker-compose deployment