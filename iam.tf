
# Caveat: AWS instance profiles oonly allows 1 role/1 profile
# "Roles in an instance profile: 1 (each instance profile can contain only 1 role)"
# Learn more: http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html

# TODO: move the policy in a json template rather than HEREDOC, easier to read and maintain1


resource "aws_iam_role" "ssh" {
  name = "ssh"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "ssh" {
  name = "ssh"
  role = "${aws_iam_role.ssh.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "iam:ListUsers"
        ],
        "Resource": [
            "*"
        ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:ListSSHPublicKeys",
        "iam:GetSSHPublicKey"
      ],
      "Resource": "arn:aws:iam::${var.aws_account}:user/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:Submit*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecs:StartTask",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_instance_profile" "ssh_test_demo" {
  name = "ssh_test_demo"
  roles = ["${aws_iam_role.ssh.name}"]
}
