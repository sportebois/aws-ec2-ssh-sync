# --- Some instance to run our services onto

resource "aws_instance" "ssh_test_demo" {
  # ami = "ami-4d795c5a" # CoreOS HVM  stable AMI for us-esat-1, then ssh connectin is done with core@ip...

  ami = "ami-55870742" # ECS-optimized AMI for us-east-1
  # Check http://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html for the ami ids for each region
  # If we really want to handle multiple regions, this should come from a Map
  instance_type = "t2.micro"

  iam_instance_profile = "${aws_iam_instance_profile.ssh_test_demo.name}"

  security_groups = ["${aws_security_group.ssh_test_demo.name}"]

  # Default key for ec2 user ssh access
  key_name = "ops"


  # Connection used by the provisionners below to access the instance
  connection {
    user = "ec2-user"
    private_key = "${file("${path.module}/files/keys/ops")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ec2-user/tf_files"
    ]
  }

  # Copy the ssh-updates file to the new instance
  provisioner "file" {
    source = "files/ec2ssh/"
    destination = "/home/ec2-user/tf_files"
  }
  /*
  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user/tf_files",
      "chmod +x *.sh",
      "sudo ./install.sh"
    ]
  }
  */

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
