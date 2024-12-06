variable "instance_name" {
  type = string
}

variable "ami" {
  type    = string
  default = "ami-04cb1684c278156a3"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "iam_instance_profile" {
  type = string
}
