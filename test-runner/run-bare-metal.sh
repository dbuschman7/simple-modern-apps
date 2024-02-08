#! /bin/sh
set -e 

source ../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script

function usage() {
    echo "Usage: $0 <environment> <language> <config-port> <run-stats-port>"
    echo " where: "
    echo "      environment: dave, dev, companyx"
    echo "      language: rust, go, scala"
    echo "      config-port: 5000(assumed), 5001, 5002"
    echo "      run-stats-port: 8080(assumed), 8081, 8082"

    die 
}


[ -n "$1" ] || die "environment is required"
[ -n "$2" ] || die "language is required"

ENVIRONMENT="$1"
LANGUAGE="$2"
CONFIG_PORT=${3:-5000}
RUN_STATS_PORT=${4:-8080}

export CONFIG_SERVICE_ADDR="localhost:${CONFIG_PORT}" 
export RUN_STATS_SERVICE_ADDR="http://localhost:${RUN_STATS_PORT}/query"

go run test-runner.go run-stats-client.go --environment $ENVIRONMENT --language $LANGUAGE ; echo "$?"
