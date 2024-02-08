#! /bin/sh
set -e 

source ../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script

function usage() {
    echo "Usage: $0 <port>"
    echo " where: "
    echo "      port: 5000(assumed), 5001, 5002"
    die 
}

PORT=${1:-5000}

go run config-service.go --port $PORT ; echo "$?"



