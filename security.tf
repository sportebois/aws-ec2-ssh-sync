
/*resource "aws_vpc" "vpc" {
  tags {
    Name = "ssh_test_demo"
  }
  cidr_block = "10.0.0.0/16"
}*/


# --- A security group is needed only to be able to connect to our instance
resource "aws_security_group" "ssh_test_demo" {
  name = "ssh_test_demo"
  description = "Allow all inbound traffic"

//  vpc_id = "${aws_vpc.vpc.id}"

  # SSH config
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = "${var.admin_public_ips}"
  }

//  # Note: For ecs usage, Https outboud traffic to ssm.us-east-1.amazonaws.com and https://ecs.us-east-1.amazonaws.com must be allowed

  # Web traffic - with tunneling
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Web traffic - direct (or direct through APIGateway)
  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Scope = "ssh_test_demo"
  }
}
