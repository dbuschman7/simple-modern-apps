#!/bin/sh 
set -ex

source ../../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script
source ./.env

function usage() {
    echo "Usage: $0 <alias> <version>"
    die 
}

[ "$#" -eq 2 ] || die "1 argument required, $# provided"
echo $2 | grep -E -q '^[0-9]+$' || die "Numeric argument required, $1 provided"

ALIAS=${1:-"unknown"}
VERSION_TO_USE=$2


ALIAS=$( aws lambda update-alias \
    --name ${ALIAS} \
	--function-name ${APP_NAME} \
	--region ${AWS_REGION} \
    --function-version $VERSION_TO_USE \
    --output json )
 
echo "Alias updated to: --->$ALIAS<---"