# simple-modern-apps

Test bed for comparing modern languages and interactions in simple ways with orchestrated infrastructure

## Diagram of processes

![Architecture](./diagrams/Overview_Architecture.drawio.svg)

## Overall goals

* Determine how Rust and Go compare against Scala for small app development
* Learn Go first, then Rust as priority
* Keep it simple and use the built in functionality first, then libraries
* Use shell scripts to document the steps for future recall
* Use Scala-cli instead to Sbt to keep it simple
* Terraform for infrastructure that is common across apps
* Do not worry about packaging and optimization initially, maybe down the road.

## Specific Goals

* Concurrency and thread safety - Scala has TrieMap, what about Go, Rust
* gRPC friendly-ness
* GraphQL friendly-ness
* Lambda friendly-ness deployed via Docker
* 12-factor as much as possible

## AWS Lambda

[Go version README](./lambda/go/README.md)

* write in all 3 languages - Scala, Go, Rust
* deploy to ECR as docker image
* Publish in AWS via Terraform with versions
* Deploy version to aliases to 'make them live'
  
## Config service

[Go version README](./config-service/README.md)

* Deployed as a Daemon Set(local networking) on each node
* Use gRPC as the communication protocol
* Schema first strategy with simple RPC call

## Run Stats Service

[Go version README](./run-stats-service/README.md)

* Use GraphQL to server both user facing UI and backend facing API needs
* Schema first approach
* Mutation to post data
* Query to see results

## Test Runner

[Go version README](./test-runner/README.md)

* load config on startup from config-service
* make direct call to AWS Lambda from a given language
* log the duration to run stats service
* repeat iterations with interval
