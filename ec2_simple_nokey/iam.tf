
# Caveat: AWS instance profiles oonly allows 1 role/1 profile
# "Roles in an instance profile: 1 (each instance profile can contain only 1 role)"
# Learn more: http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html


resource "aws_iam_role" "ssh" {
  name = "ssh"
  assume_role_policy = "${file("resources/iam_assume_role_policy.json")}"
}


resource "aws_iam_role_policy" "ssh" {
  name = "ssh"
  role = "${aws_iam_role.ssh.id}"
  policy = "${data.template_file.iam_role_policy.rendered}"
}


resource "aws_iam_instance_profile" "ssh_test_demo" {
  name = "ssh_test_demo"
  roles = ["${aws_iam_role.ssh.name}"]
}


# The policy json has some dynamic content, like our AWS account.
data "template_file" "iam_role_policy" {
  template = "${file("resources/iam_role_policy.template.json")}"

  vars {
    aws_account = "${var.aws_account}"
  }
}
