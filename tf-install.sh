#!/bin/bash
# pre requisits
sudo apt install -y curl jq unzip

function terraform-install() {
  [[ -f ${HOME}/bin/terraform ]] && echo "`${HOME}/bin/terraform version` already installed at ${HOME}/bin/terraform" && return 0
  
  # assign variable (LATEST_URL) 
  LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort --version-sort | egrep -v 'rc|beta|alpha' | egrep 'linux.*amd64' |tail -1)

  # pull from terraform and place in the folder (/tmp/terraform.zip)
  curl ${LATEST_URL} > /tmp/terraform.zip

  # make directory in the current user's bin folder.
  mkdir -p ${HOME}/bin
  
  # change directory and unzip in the folder path 
  (cd ${HOME}/bin && unzip /tmp/terraform.zip)
  if [[ -z $(grep 'export PATH=${HOME}/bin:${PATH}' ~/.bashrc) ]]; then
  	echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
  fi
  
  echo "Installed: `${HOME}/bin/terraform version`"
  
  cat - << EOF 
 
Run the following to reload your PATH with terraform:
  source ~/.bashrc
EOF
}

# calling the defined function above
terraform-install
