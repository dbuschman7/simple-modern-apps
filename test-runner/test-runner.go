package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"math/rand"
	"os"
	"time"

	pb "github.com/dbuschman7/config-service/config"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

var (
	language    = flag.String("language", "unspecified", "Feature name to get config for")
	environment = flag.String("environment", "dev", "Environment to get config for")
	iterations  = flag.Int("iterations", 10, "Number of iterations to run")
	delay       = flag.Int("delay", 10, "Delay between iterations in seconds")
	r           = rand.New(rand.NewSource(time.Now().UnixNano()))
)

// Why is this not bulit into the standard library?
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if len(value) == 0 {
		return defaultValue
	}
	return value
}

type PostTestRun string

func PostTestRunToSmokeTestService(url string, runNumber int, language string, duration int64) PostTestRun {
	fmt.Println(fmt.Sprintf("Posting test %v run for %s with duration %d", runNumber, language, duration))
	return "PostTestRun"
}

func main() {
	flag.Parse()

	configServiceAddr := getEnv("CONFIG_SERVICE_ADDR", "config-service.common.svc:8080")
	runStatsServiceAddr := getEnv("RUN_STATS_SERVICE_ADDR", "run-stats-service.test.svc:8080")

	// accountId := getEnv("AWS_ACCOUNT_ID", "unknown")

	// Set up a connection to the server.
	conn, err := grpc.Dial(configServiceAddr, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	client := pb.NewConfigServiceClient(conn)

	// Contact the server and print out its response.
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	cfg, err := client.GetFeatureConfig(ctx, &pb.Application{Name: "test-runner", Feature: *language})
	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}
	log.Printf("Enabled: %s", cfg.GetEnabled())
	log.Printf("MaxFoo: %d", cfg.GetMaxFoo())
	log.Printf("PrefixBar: %s", cfg.GetPrefixBar())

	log.Printf("Config Read!")

	//	var lambdaName string = "unknown"

	switch *language {
	case "go":
		log.Printf("Go is enabled!")
		//		lambdaName = "language-demo-go"
	case "rust":
		log.Printf("Rust is enabled!")
		//		lambdaName = "language-demo-rust"
	case "scala":
		log.Printf("Scala lambda is enabled!")
		//		lambdaName = "language-demo-scala"
	default:
		log.Printf("Unknown language: %s", *language)
		//		lambdaName = "unknown"
	}

	for i := 0; i < *iterations; i++ {
		// TODO: call the lambda here
		random := r.Int63n(1000)

		PostTestRunToSmokeTestService(smokeTestServiceAddr, i, *language, random)
		time.Sleep(time.Duration(*delay) * time.Second)
	}

	os.Exit(1)
}
