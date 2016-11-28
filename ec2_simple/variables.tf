variable "aws_access_key" {
  description = "A valid AWS ACCESS KEY. Do not place it here, but rather in a secrets.tfvars file."
  type = "string"
}

variable "aws_secret_key" {
  description = "A valid AWS SECRET KEY. Do not place it here, but rather in a secrets.tfvars file."
  type = "string"
}

variable "aws_account" {
  description = "Your AWS Account number. Do not place it here, but rather in a secrets.tfvars file."
  type = "string"
}

variable "aws_region" {
  type = "string"
  default = "us-east-1"
}

variable "private_key_name" {
  description = "Name of the EC2 private key to use to provision the instances."
  type = "string"
}

variable "private_key_path" {
  description = "Path to the private key registred in EC2 with the name put in private_key_name"
  type = "string"
}

variable "stack_name" {
  type = "string"
  default = "ssh_test_demo"
}

variable "admin_public_ips" {
  description = "List of public IPs to grant access to the EC2 instances"
  type = "list"
  default = [
    "0.0.0.0/0"
  ]
}
