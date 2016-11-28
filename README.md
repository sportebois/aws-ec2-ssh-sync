

# Dry-run / plan

    terraform plan -var-file="secret.tfvars"

# Create/update your stack

    terraform apply -var-file="secret.tfvars"

# Test it

ssh sebastien@${public-ip}

    "commands": {
                  "a_configure_sshd_command": {
                    "command": "sed -i 's:#AuthorizedKeysCommand none:AuthorizedKeysCommand /opt/authorized_keys_command.sh:g' /etc/ssh/sshd_config"
                  },
                  "b_configure_sshd_commanduser": {
                    "command": "sed -i 's:#AuthorizedKeysCommandUser nobody:AuthorizedKeysCommandUser nobody:g' /etc/ssh/sshd_config"
                  },
                  "c_import_users": {
                    "command": "./import_users.sh",
                    "cwd": "/opt"
                  }
                },
                "services": {
                  "sysvinit": {
                    "cfn-hup": {
                      "enabled": "true",
                      "ensureRunning": "true",
                      "files": [
                        "/etc/cfn/cfn-hup.conf",
                        "/etc/cfn/hooks.d/cfn-auto-reloader.conf"
                      ]
                    },
                    "sshd": {
                      "enabled": "true",
                      "ensureRunning": "true",
                      "commands": [
                        "a_configure_sshd_command",
                        "b_configure_sshd_commanduser"
                      ]
                    }
                  }
                }
              }
