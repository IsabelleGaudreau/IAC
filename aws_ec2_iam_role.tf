# ensure this instance profile holds the same
# name as the IAM role below for convenience
resource "aws_iam_instance_profile" "smp_iac_ec2_instance" {
  name = "${aws_iam_role.smp_iac_ec2_instance.name}"
  roles = ["${aws_iam_role.smp_iac_ec2_instance.name}"]
}

resource "aws_iam_role" "smp_iac_ec2_instance" {
  name = "smp-iac-ec2-instance"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}