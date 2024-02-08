package main

import (
	"context"
	"fmt"
	"sync"

	"github.com/machinebox/graphql"
)

//
// Singleton pattern
// ////////////////////

var lock = &sync.Mutex{}

type single struct {
}

var clientUrl *string
var singleInstance *graphql.Client

func getInstance() *graphql.Client {
	if singleInstance == nil && clientUrl != nil {
		lock.Lock()
		defer lock.Unlock()
		if singleInstance == nil {
			//			fmt.Println(fmt.Sprintf("Creating single instance now - %v", *clientUrl))
			singleInstance = graphql.NewClient(*clientUrl)
			// } else {
			// 	fmt.Println("Single instance already created.")
		}
		// } else {
		// 	fmt.Println("Single instance already created.")
	}

	//	fmt.Println("getInstance() returning singleInstance")
	return singleInstance
}

// Client code
// ////////////////////
type PostTestRunResponse struct {
	Response struct {
		Success bool
	}
}

func PostTestRunToSmokeTestService(url string, runNumber int, language string, duration int64) bool {

	// TODO: make this better abd more thread
	if clientUrl == nil {
		clientUrl = &url
	}

	fmt.Println(fmt.Sprintf("Posting test %v run for %s with duration %d", runNumber, language, duration))
	mutation := fmt.Sprintf(`
	mutation {
		postTestRun(run: {language:"%s", timePerRunMs:%d }){success}  
	}`, language, duration)

	request := graphql.NewRequest(mutation)

	// fmt.Println("Request: ", mutation)

	var response PostTestRunResponse

	err := getInstance().Run(context.Background(), request, &response)
	if err != nil {
		panic(err)
	}

	return response.Response.Success
}
