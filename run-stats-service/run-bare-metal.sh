#! /bin/sh 
set -e 

source ../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script

function usage() {
    echo "Usage: $0 <port>"
    echo " where: "
    echo "      port: 8080(assumed) or any other port number"
    die 
}

export PORT=${1:-8080}

go run run-stats-service.go ; echo "$?"



