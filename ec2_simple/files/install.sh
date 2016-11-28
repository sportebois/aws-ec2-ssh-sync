#!/bin/bash

# Install PIP to be able to install the AWS Cli (later used to get the ssh keys)
#curl -O https://bootstrap.pypa.io/get-pip.py
#sudo python27 get-pip.py
#sudo /usr/local/bin/pip install awscli

sudo yum update -y
sudo yum install aws-cli -y

sudo cp authorized_keys_command.sh /opt/authorized_keys_command.sh
sudo cp import_users.sh /opt/import_users.sh

sudo sed -i 's:#AuthorizedKeysCommand none:AuthorizedKeysCommand /opt/authorized_keys_command.sh:g' /etc/ssh/sshd_config
sudo sed -i 's:#AuthorizedKeysCommandUser nobody:AuthorizedKeysCommandUser nobody:g' /etc/ssh/sshd_config

# Refresh users frequently
sudo cp import_users.cron /etc/cron.d/import_users
sudo chmod 0644 /etc/cron.d/import_users

# Run it immediately
sudo /opt/import_users.sh

sudo service sshd restart
