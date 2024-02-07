#!/bin/sh 
set -ex 


aws ecr get-login-password --region ${AWS_REGION}  | docker login -u AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# DONE 
