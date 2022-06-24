#!/bin/bash
lib_proxy='http://10.3.100.201:3128'
export GH_TOKEN="$1"
export GH_ACTOR="$2"

export http_proxy="$lib_proxy"
export https_proxy="$lib_proxy"

git config --global http.proxy $lib_proxy

# make the 'logs' dir if not there
mkdir -p logs group_vars/all host_vars/all

# Install Ansible Galaxy Collections
printf "[*] Installing Ansible Galaxy Collections...\n"
ansible-galaxy collection install git+https://${GH_ACTOR}:${GH_TOKEN}@github.com/library-ucsb/library-ansible-collections-core.git --force
ansible-galaxy collection install git+https://${GH_ACTOR}:${GH_TOKEN}@github.com/library-ucsb/iac-ansible-collections-legacy.git --force

# Install Ansible Galaxy Roles
printf "[*] Installing Ansible Galaxy Roles...\n"
ansible-galaxy install -r requirements.yml

printf "[*] Done.\n"
exit 0