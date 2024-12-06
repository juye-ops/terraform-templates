variable "vpc_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "endpoint_info" {
  type = object({
    ec2messages = object({
      service_name        = string
      vpc_endpoint_type   = string
      private_dns_enabled = bool
    }),
    ssm = object({
      service_name        = string
      vpc_endpoint_type   = string
      private_dns_enabled = bool
    }),
    ssmmessages = object({
      service_name        = string
      vpc_endpoint_type   = string
      private_dns_enabled = bool
    })
  })
}
