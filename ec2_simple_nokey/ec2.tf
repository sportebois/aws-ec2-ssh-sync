# --- Some instance to run our services onto

resource "aws_instance" "ssh_test_demo" {

  ami = "${lookup(var.aws_ami, var.aws_region)}"
  availability_zone = "${lookup(var.aws_availability_zone, var.aws_region)}"

  # Check http://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html for the ami ids for each region
  # If we really want to handle multiple regions, this should come from a Map
  instance_type = "t2.micro"

  iam_instance_profile = "${aws_iam_instance_profile.ssh_test_demo.name}"

  security_groups = ["${aws_security_group.ssh_test_demo.name}"]

  # Default key for ec2 user ssh access
  key_name = "${var.private_key_name}"

  user_data = "${file("resources/instance_user_data.sh")}"

  tags {
    Name = "ssh_test_demo"
  }
}


# --- Define some output to easily get the public IP

output "ec2_instance_public_dns" {
  value = "${aws_instance.ssh_test_demo.public_dns}"
}
output "ec2_instance_public_ip" {
  value = "${aws_instance.ssh_test_demo.public_ip}"
}
