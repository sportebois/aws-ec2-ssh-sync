#!/bin/bash

aws iam list-users --query "Users[].[UserName]" --output text | while read User; do
  if id -u "$User" >/dev/null 2>&1; then
    echo "$User exists"
  else
    source /etc/os-release
    if [ "$NAME" == "Ubuntu" ]; then
      /usr/sbin/useradd -m "$User" -s /bin/bash
    elif [ "$NAME" == "Amazon Linux AMI" ]; then
      /usr/sbin/adduser "$User"
    fi
    echo "$User ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$User"
  fi
done
