#! /bin/sh 

set -ex

source ../../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script
source ./.env

aws lambda list-aliases \
    --function-name ${APP_NAME} \
	--region ${AWS_REGION} \
    --output json
