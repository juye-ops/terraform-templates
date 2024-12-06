variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "private_subnet" {
  type = object({
    cidr_block        = string,
    availability_zone = string
  })
}


variable "onprem" {
  type = object({
    ip_address = string
    ipv4_network_cidr = string
  })
}