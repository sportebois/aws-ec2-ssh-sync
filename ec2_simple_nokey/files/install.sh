#!/bin/bash

# Install AWS Cli
source /etc/os-release
if [ "$NAME" == "Ubuntu" ]; then
  ssh_service="ssh"
  sudo apt-get update
  sudo apt-get -y install python-pip
  sudo pip install awscli
elif [ "$NAME" == "Amazon Linux AMI" ]; then
  ssh_service="sshd"
  sudo yum update -y
  sudo yum install aws-cli -y
fi

sudo cp authorized_keys_command.sh /opt/authorized_keys_command.sh
sudo cp import_users.sh /opt/import_users.sh

sudo echo -e "\nAuthorizedKeysCommand /opt/authorized_keys_command.sh" >> /etc/ssh/sshd_config
sudo echo -e "\nAuthorizedKeysCommandUser nobody" >> /etc/ssh/sshd_config

# Refresh users frequently
sudo cp import_users.cron /etc/cron.d/import_users
sudo chmod 0644 /etc/cron.d/import_users

# Run it immediately
sudo /opt/import_users.sh

sudo service $ssh_service restart
