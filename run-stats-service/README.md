# Run Stats Service

## Setup

* define the GraphQL schema for making calls
* stand up server
* return collect data into go version to Scala TrieMap - [Map Database](./graph/collection.go)
* [version.txt](./version.txt) conatains the active image version tag
* [Dockerfile](./Dockerfile) assembles the image
* [run-stats-service.go](./run-stats-service.go) - Application main

## Steps

* [build.sh](./build.sh) -- cleanup, code gne, build and package
* [run-bare-metal.sh](./run-bare-metal.sh) -- run local on laptop
* TODO - run as k8s DaemonSet with local network only service
* TODO - include in helm chart and docker-compose deployment

## Regenerate GraphQL schema

* See build.sh, happens every build for now

## Example mutations

``` graphql
mutation {
  postTestRun(run: {language:"dave", timePerRunMs:1234 })    
}

mutation {
  postTestRun(run: {language:"dave", timePerRunMs:2345 })    
}

mutation {
   postTestRun(run: {language:"allen", timePerRunMs:2345})
}

mutation {
  postTestRun(run: {language:"allen", timePerRunMs:3456 })    
}
```

## Example Query

```graphql
query {
  stats {
    language
    count
    average
  }
}
```
