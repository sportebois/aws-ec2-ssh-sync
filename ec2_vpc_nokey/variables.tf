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
  /*
  Sample white-list:
  default = ["75.98.128.74/32"]
  */
}


# ECS optimized AMIs
# Some regions and availability zones are ignored here, because of lack of support for ECS (our use case), but edit/complete this at will
# No ECS support in Seoul, so we ignore ap-northeast-2
# No ECS support in Mumbai, so we ignore ap-south-1
# No ECS support in Sao Paulo, so we ignore sa-east-1

variable "aws_ami" {
  description = "amazon-ecs-optimized AMI (amzn-ami-2016.09.b-amazon-ecs-optimized)"
  type = "map"
  default = {
    us-east-1 = "ami-eca289fb"
    us-east-2 = "ami-446f3521"
    us-west-1 = "ami-9fadf8ff"
    us-west-2 = "ami-7abc111a"
    eu-west-1 = "ami-a1491ad2"
    eu-central-1 = "ami-54f5303b"
    ap-northeast-1 = "ami-9cd57ffd"
    ap-southeast-1 = "ami-a900a3ca"
    ap-southeast-2 = "ami-5781be34"
  }
}

# Because in this simple sample we're only targeting a single AZ for each region, we just need a simple map
variable "aws_availability_zone" {
  type = "map"
  default = {
    us-east-1 = "us-east-1b"
    us-east-2 = "us-east-2b"
    us-west-1 = "us-west-1b"
    us-west-2 = "us-west-2b"
    eu-west-1 = "eu-west-1b"
    eu-central-1 = "eu-central-1b"
    ap-northeast-1 = "ap-northeast-c"
    ap-southeast-1 = "ap-southeast-1b"
    ap-southeast-2 = "ap-southeast-2b"
  }
}
