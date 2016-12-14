#!/bin/bash

# Install Git
source /etc/os-release
if [ "$NAME" == "Ubuntu" ]; then
  sudo apt-get -y install git
elif [ "$NAME" == "Amazon Linux AMI" ]; then
  sudo yum install -y git
fi

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

# In some real ECS use, you'd might want to add the following lines and use a Terraform template_file (or directly the value)
# Make sure the instance has the correct cluster registered
# echo ECS_CLUSTER=${ecs_cluster_name} >> /etc/ecs/ecs.config
