module github.com/dbuschman7/test-runner

go 1.21.6

require (
	github.com/dbuschman7/config-service v0.0.0-00010101000000-000000000000
	github.com/machinebox/graphql v0.2.2
	google.golang.org/grpc v1.61.0
	google.golang.org/protobuf v1.32.0
)

require (
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/matryer/is v1.4.1 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	golang.org/x/net v0.20.0 // indirect
	golang.org/x/sys v0.16.0 // indirect
	golang.org/x/text v0.14.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240123012728-ef4313101c80 // indirect
)

replace github.com/dbuschman7/config-service => ../config-service
