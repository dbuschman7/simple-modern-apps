# Smoke Test Service

## Setup

```shell
go mod init github.com/dbuschman7/run-stats-service
go mod tidy
go get -d github.com/99designs/gqlgen
go run github.com/99designs/gqlgen init
go run server.go
```

## Regenerate GraphQL schema

``` shell 
go run github.com/99designs/gqlgen generate
go run server.go
```

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

## Exmaple Query

```graphql
query {
  stats {
    language
    count
    average
  }
}
```
