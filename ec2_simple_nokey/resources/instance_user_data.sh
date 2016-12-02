#!/bin/bash

# Install Git
sudo yum install -y git

# Fetch setup files from Github over HTTPS. You can choose any other secure way to fetch your setup files
cd /tmp
mkdir setup
cd setup/
git init
git remote add -f origin https://github.com/sportebois/aws-ec2-ssh-sync.git
git config core.sparseCheckout true
echo "ec2_simple_nokey/files/" >> .git/info/sparse-checkout
git pull --depth=1 origin master

# Then run the setup
cd ec2_simple_nokey/files
chmod +x *.sh
sudo ./install.sh
