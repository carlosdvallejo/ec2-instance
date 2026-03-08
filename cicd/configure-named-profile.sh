#!/bin/bash

set -eu

aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile cicd-profile
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile cicd-profile
aws configure set region "us-east-2" --profile cicd-profile 

aws configure list --profile cicd-profile
aws sts get-caller-identity --profile cicd-profile

output=$(aws sts get-caller-identity --profile cicd-profile)