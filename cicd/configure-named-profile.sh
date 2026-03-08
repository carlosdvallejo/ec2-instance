#!/bin/bash

set -eu

aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile $PROFILE_NAME
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile $PROFILE_NAME
aws configure set region "us-east-2" --profile $PROFILE_NAME

aws configure list --profile $PROFILE_NAME
aws sts get-caller-identity --profile $PR


output=$(aws sts get-caller-identity --profile $PROFILE_NAME)