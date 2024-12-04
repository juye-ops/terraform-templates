resource "aws_vpc_endpoint" "ssm_endpoint_ec2messages" {
  vpc_id              = var.vpc_id
  security_group_ids  = var.security_group_ids
  subnet_ids          = var.subnet_ids
  service_name        = var.endpoint_info.ec2messages.service_name
  vpc_endpoint_type   = var.endpoint_info.ec2messages.vpc_endpoint_type
  private_dns_enabled = var.endpoint_info.ec2messages.private_dns_enabled
}

resource "aws_vpc_endpoint" "ssm_endpoint_ssm" {
  vpc_id              = var.vpc_id
  security_group_ids  = var.security_group_ids
  subnet_ids          = var.subnet_ids
  service_name        = var.endpoint_info.ssm.service_name
  vpc_endpoint_type   = var.endpoint_info.ssm.vpc_endpoint_type
  private_dns_enabled = var.endpoint_info.ssm.private_dns_enabled
}

resource "aws_vpc_endpoint" "ssm_endpoint_ssmmessages" {
  vpc_id              = var.vpc_id
  security_group_ids  = var.security_group_ids
  subnet_ids          = var.subnet_ids
  service_name        = var.endpoint_info.ssmmessages.service_name
  vpc_endpoint_type   = var.endpoint_info.ssmmessages.vpc_endpoint_type
  private_dns_enabled = var.endpoint_info.ssmmessages.private_dns_enabled
}