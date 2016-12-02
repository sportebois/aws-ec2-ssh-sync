# --- Some instance to run our services onto

resource "aws_instance" "ssh_test_demo" {

  # Check http://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html for the AMI ids for each region
  # or check other sample for using an HCL map to only set the region
  ami = "ami-55870742" # ECS-optimized AMI for us-east-1
  availability_zone = "us-east-1b"

  instance_type = "t2.micro"

  iam_instance_profile = "${aws_iam_instance_profile.ssh_test_demo.name}"

  security_groups = ["${aws_security_group.ssh_test_demo.name}"]

  key_name = "${var.private_key_name}"

  # Connection used by the provisionners below to access the instance
  connection {
    user = "ec2-user"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ec2-user/tf_files"
    ]
  }

  # Copy the ssh-updates file to the new instance
  provisioner "file" {
    source = "files/"
    destination = "/home/ec2-user/tf_files"
  }

  user_data = <<EOF
#!/bin/bash
cd /home/ec2-user/tf_files
chmod +x *.sh
sudo ./install.sh
EOF

  tags {
    Name = "ssh_test_demo"
  }
}



# --- Define some output to easily get the public IP if we want to ssh into the instances

output "ec2_instance_public_dns" {
  value = "${aws_instance.ssh_test_demo.public_dns}"
}
output "ec2_instance_public_ip" {
  value = "${aws_instance.ssh_test_demo.public_ip}"
}
