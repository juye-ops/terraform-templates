resource "aws_vpc" "ssm_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "ssm_private_subnet" {
  vpc_id            = aws_vpc.ssm_vpc.id
  cidr_block        = var.private_subnet.cidr_block
  availability_zone = var.private_subnet.availability_zone
}
