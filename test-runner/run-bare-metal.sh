#! /bin/sh
set -e 

source ../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script

function usage() {
    echo "Usage: $0 <environment> <language> <port>"
    echo " where: "
    echo "      environment: dave, dev, companyx"
    echo "      language: rust, go, scala"
    echo "      port: 5000(assumed), 5001, 5002"

    die 
}


[ -n "$1" ] || die "environment is required"
[ -n "$2" ] || die "language is required"

ENVIRONMENT="$1"
LANGUAGE="$2"
PORT=${3:-5000}

export CONFIG_SERVICE_ADDR="localhost:${PORT}" 
go run test-runner.go --environment $ENVIRONMENT --language $LANGUAGE ; echo "$?"
