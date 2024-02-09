# Test-Runner

## Setup

* standup gRPC client to get config
* Create [simple client](./run-stats-client.go) to test foreign integration simplicity
* stand up server
* make call to AWS lambda and submit timing to run stats service
* [version.txt](./version.txt) contains the active image version tag
* [Dockerfile](./Dockerfile) assembles the image
* [test-runner.go](./test-runner.go) - Application main

## Steps

* [build.sh](./build.sh) -- cleanup, code gne, build and package
* [run-bare-metal.sh](./run-bare-metal.sh) -- run local on laptop
* TODO - run as k8s DaemonSet with local network only service
* TODO - include in helm chart and docker-compose deployment
