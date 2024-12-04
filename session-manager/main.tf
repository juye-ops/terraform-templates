provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = "ssm_vpc"
  cidr_block           = "10.0.0.0/23"
  enable_dns_hostnames = true
  private_subnet = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-northeast-2c"
  }
}

module "security_group" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.ssm_vpc.id
}

module "endpoint" {
  source = "./modules/endpoints"
  vpc_id = module.vpc.ssm_vpc.id
  security_group_ids = [
    module.security_group.sg_ssm.id
  ]
  subnet_ids = [
    module.vpc.ssm_private_subnet.id
  ]
  endpoint_info = {
    ec2messages = {
      service_name        = "com.amazonaws.ap-northeast-2.ec2messages"
      vpc_endpoint_type   = "Interface"
      private_dns_enabled = true
    },
    ssm = {
      service_name        = "com.amazonaws.ap-northeast-2.ssm"
      vpc_endpoint_type   = "Interface"
      private_dns_enabled = true
    },
    ssmmessages = {
      service_name        = "com.amazonaws.ap-northeast-2.ssmmessages"
      vpc_endpoint_type   = "Interface"
      private_dns_enabled = true
    }
  }
}

module "iam_role" {
  source     = "./modules/iam"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

module "ec2_instance" {
  source                      = "./modules/instance"
  instance_name               = "ec2-instance"
  ami                         = "ami-04cb1684c278156a3"
  instance_type               = "t2.micro"
  key_name                    = ""
  associate_public_ip_address = true
  subnet_id                   = module.vpc.ssm_private_subnet.id
  vpc_security_group_ids = [
    module.security_group.sg_ec2.id
  ]
  iam_instance_profile = module.iam_role.ssm_instance_profile.id
}
