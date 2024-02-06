package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	pb "github.com/dbuschman7/config-service/config"
	"google.golang.org/grpc"
)

var (
	port = flag.Int("port", 50052, "The server port")
)

// server is used to implement helloworld.GreeterServer.
type server struct {
	pb.UnimplementedConfigServiceServer
}

func (s *server) GetFeatureConfig(ctx context.Context, in *pb.Application) (*pb.FeatureConfig, error) {
	log.Printf("Received: %v(%v)", in.GetName(), in.GetFeature())
	return &pb.FeatureConfig{Enabled: true, MaxFoo: 42, PrefixBar: "baz"}, nil
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterConfigServiceServer(s, &server{})
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
