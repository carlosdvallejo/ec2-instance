#!/bin/bash

set -eu

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux2/hashicorp.repo
sudo yum -y install terraform
terraform -version

output=$(terraform -version)