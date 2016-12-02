# User-specific SSH keys management for EC2 instances

Notes: lot of duplication acorss the samples, because we want each sample to be self-sufficient (you can take the one you like and throw out the others)

Goal: usually - 1 keypair defined for each EC2 region and associated to your instance that you can use with a ec2-user (or other used for different AMIs)
With this setup: no longer mandatory to have region-defined key (but you could), and automatic sync of users from IAM, each one with their own ssh-keys.


## What's in there


## Note about IAM Roles and Profiles

Detail about the EC2 IAM restriction: Roles in an instance profile: 1 (each instance profile can contain only 1 role)



## Config

After initial cloning/downloading, you need to setup your secrets

    cp secret.sample.fvars secret.tfvars

Then open and edit `secret.tfvars` to enter your real secrets (aws credentials).
These ones will be given to Terraform so that it can perform AWS commands on your behalf.
It doesn't need ot be your credential. At the end of the day, the IAM users you use will need all the rights to perform all the resources creation we do in this terraform plan.


## Dry-run / plan

    terraform plan -var-file="secret.tfvars"


## Create/update your stack

    terraform apply -var-file="secret.tfvars"


## Test it

The public IP/dns of your instance is shown in Terraform outputs. In the following snippet, `awsUsername` contains the name of your AWS IAM user (if you need to specify the ssh key, use `-i path/to/your/key` like for any ssh connection)

    ec2PublicIp=$(terraform output | grep 'ec2_instance_public_ip' | sed 's@.*= @@g')
    ssh ${awsUsername}@${ec2PublicIp}


## Where to go from here

Better Bastion/Nat + public/private subnets
Better user creation (not all)
Add CloudTrail login for IAM activity
... 


## Credits

All the hard work has been done by Michael Wittig, and his presentation of the 'hack' to use CodeCommit's ssh keys or EC2 instances is brilliant. Go read [Manage AWS EC2 SSH access with IAM](https://cloudonaut.io/manage-aws-ec2-ssh-access-with-iam/) to learn more.
This repo is only about using the same technique with Terraform, because we'd prefer to use Terraform than CloudFormation.


## TODO / next steps

[ ] Basic arch diagram to make this easier to get at first glance
[ ] do a clean variation using CoreOS
[ ] do a bastion variation ? 
 

