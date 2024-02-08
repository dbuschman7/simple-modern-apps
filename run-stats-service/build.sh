#! /bin/sh 
set -e 

go mod tidy 
go run github.com/99designs/gqlgen generate
go build run-stats-service.go


