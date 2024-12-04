output "ssm_vpc" {
  value = aws_vpc.ssm_vpc
}

output "ssm_private_subnet" {
  value = aws_subnet.ssm_private_subnet
}
