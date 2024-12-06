resource "aws_security_group" "sg_ec2" {
  vpc_id = var.vpc_id  
}

resource "aws_security_group_rule" "sg_ec2_all_egress" {
  type             = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2.id
}

# resource "aws_security_group_rule" "sg_ec2_icmp_ingress" {
#   type             = "ingress"
#   from_port        = -1
#   to_port          = -1
#   protocol         = "icmp"
#   cidr_blocks      = [var.onprem.cidr_block]
#   security_group_id = aws_security_group.sg_ec2.id
# }



resource "aws_security_group" "sg_ssm" {
  vpc_id = var.vpc_id  
}

resource "aws_security_group_rule" "sg_ssm_https_ingress" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ssm.id
}

resource "aws_security_group_rule" "sg_ssm_all_egress" {
  type             = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ssm.id
}