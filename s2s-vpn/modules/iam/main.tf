resource "aws_iam_role" "ssm_iam_role" {
  name               = "AmazonSSMManagedInstanceCore"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = var.policy_arn
  role = aws_iam_role.ssm_iam_role.name
}


resource "aws_iam_instance_profile" "ssm_iam_instance_profile" {
  name = "AmazonSSMManagedInstanceCore"
  role = aws_iam_role.ssm_iam_role.id
}
