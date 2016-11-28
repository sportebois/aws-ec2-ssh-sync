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
  /*
  Sample white-list:
  default = ["75.98.128.74/32"]
  */
}
