#! /bin/sh 
set -e 

source ../../common/base_functions.sh
scriptLocalDir $0 # Force our script to run in the same directory as the script
source ./.env

WHERE=$1


function usage() {
    echo "Usage: $0 <where>"
    echo "where: [ HUB | ECR ]"
    die
}

if [ -z "$WHERE" ]; then
    usage
fi

VERSION_TO_USE="$( cat version.txt )"


case $WHERE in
    HUB)
        docker tag $APP_NAME:$VERSION_TO_USE $DOCKER_HUB_USER/$APP_NAME:$VERSION_TO_USE
        docker push $DOCKER_HUB_USER/$APP_NAME:$VERSION_TO_USE
        ;;
    ECR)
        docker tag $APP_NAME:$VERSION_TO_USE ${ECR_REPO}:$VERSION_TO_USE
        docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/$APP_NAME:$VERSION_TO_USE

        VERSION_OUT=$( aws lambda update-function-code \
            --function-name ${APP_NAME} \
            --region ${AWS_REGION} \
            --image-uri ${ECR_REPO}:${VERSION_TO_USE} \
            --publish \
            --cli-connect-timeout 6000 \
            --output json \
            --query Version | tr -d '"'
        )
        echo "Lambda published to version --->$VERSION_OUT<---"

        ;;
    *)
        echo "Unknown option: $WHERE"
        usage
        ;;
esac