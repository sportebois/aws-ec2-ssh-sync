# Do not change the values here, but rather place them in secret.tfvars (gitignored) or in another tfvars file to pass to Terraform

variable "aws_access_key" {
  description = "A valid AWS ACCESS KEY"
  type = "string"
}

variable "aws_secret_key" {
  description = "A valid AWS SECRET KEY"
  type = "string"
}

variable "aws_account" {
  description = "Your AWS Account number"
  type = "string"
}

variable "aws_region" {
  type = "string"
  default = "us-east-1"
}

variable "private_key_name" {
  description = "Name of the EC2 private key to use to provision the instances in that region."
  type = "string"
}

variable "private_key_path" {
  description = "Path to the private key registred to EC2 keypair with the name put in private_key_name"
  type = "string"
}

variable "admin_public_ips" {
  description = "List of public IPs to grant access to the EC2 instances"
  type = "list"
  default = [
    "0.0.0.0/0"
  ]
}
