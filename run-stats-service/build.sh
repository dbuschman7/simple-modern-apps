#! /bin/sh 
set -e 

go mod tidy 
go run github.com/99designs/gqlgen generate
go build server.go
go run server.go 

