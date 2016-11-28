

resource "aws_vpc" "ssh_test_demo" {
  # For real use-case, you'd probably prefer something more restrictive to avoir overlaping between different regions
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "ssh_test_demo"
  }
}

# Configure internet connection
resource "aws_internet_gateway" "ssh_test_demo" {
  vpc_id = "${aws_vpc.ssh_test_demo.id}"

  tags {
    Name = "ssh_test_demo"
  }
}

# Public subnets

resource "aws_subnet" "us-east-1b-public" {
  vpc_id = "${aws_vpc.ssh_test_demo.id}"

  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1b"

  tags {
    Name = "ssh_test_demo"
  }
}

resource "aws_subnet" "us-east-1a-public" {
  vpc_id = "${aws_vpc.ssh_test_demo.id}"

  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "ssh_test_demo"
  }
}

resource "aws_route_table" "us-east-1-public" {
  vpc_id = "${aws_vpc.ssh_test_demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ssh_test_demo.id}"
  }

  tags {
    Name = "ssh_test_demo"
  }
}


resource "aws_route_table_association" "us-east-1b-public" {
  subnet_id = "${aws_subnet.us-east-1b-public.id}"
  route_table_id = "${aws_route_table.us-east-1-public.id}"
}

resource "aws_route_table_association" "us-east-1d-public" {
  subnet_id = "${aws_subnet.us-east-1a-public.id}"
  route_table_id = "${aws_route_table.us-east-1-public.id}"
}

// ElasticIP isn't required, you can leave this commented or enable it
//resource "aws_eip" "ip" {
//  instance = "${aws_instance.ssh_test_demo.id}"
//  vpc = true
//}
//
//output "elastic_ip_used" {
//  value = "${aws_eip.ip.public_ip}"
//}


# --- A security group is needed only to be able to connect to our instance
resource "aws_security_group" "ssh_test_demo" {
  name = "ssh_test_demo"
  description = "Allow all inbound traffic"

  vpc_id = "${aws_vpc.ssh_test_demo.id}"

  // Note: For ecs usage, Https outboud traffic to ssm.us-east-1.amazonaws.com and https://ecs.us-east-1.amazonaws.com must be allowed

  # SSH config
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = "${var.admin_public_ips}"
  }

  # Web traffic
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
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
