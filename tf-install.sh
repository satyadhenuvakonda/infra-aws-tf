#! /bin/bash

# install Terraform
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip -O /tmp/terraform.zip
unzip /tmp/terraform.zip -d /tmp/
mv /tmp/terraform /usr/bin/terraform
chmod +x /usr/bin/terraform
rm -rf /tmp/terraform.zip