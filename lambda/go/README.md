# AWS Lambda written in Go

# Setup
* [version.txt](./version.txt) conatains the active image version tag
* [Dockerfile](./Dockerfile) assembles the image
* [version.sh](./versions.sh) shows the current alias assignments
* [lambda.go](./lambda.go) - Application main

## Steps

* [terrafrom](./terraform/main.tf) - setup lambda function and all aliases
* [build.sh](./build.sh) -- cleanup, code gne, build and package
* [publish.sh](./publish.sh) -- use `aws lambda update-function-code` to publish a new version
* [deploy.sh](./deploy.sh) -- assign a given image version to an alias to `deploy` it
  