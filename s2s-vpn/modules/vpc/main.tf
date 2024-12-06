resource "aws_vpc" "s2s_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "s2s_private_subnet" {
  vpc_id            = aws_vpc.s2s_vpc.id
  cidr_block        = var.private_subnet.cidr_block
  availability_zone = var.private_subnet.availability_zone
}

resource "aws_route_table" "s2s_private_rt" {
  vpc_id = aws_vpc.s2s_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_vpn_gateway.s2s_vgw.id
  }
}

resource "aws_route_table_association" "route_subnet_connection" {
  subnet_id      = aws_subnet.s2s_private_subnet.id
  route_table_id = aws_route_table.s2s_private_rt.id
}



resource "aws_vpn_gateway" "s2s_vgw" {
  vpc_id = aws_vpc.s2s_vpc.id
}

resource "aws_customer_gateway" "s2s_cgw" {
  bgp_asn    = "65000"
  ip_address = var.onprem.ip_address
  type       = "ipsec.1"
}



resource "aws_vpn_connection" "s2s_vpn" {
  vpn_gateway_id           = aws_vpn_gateway.s2s_vgw.id
  customer_gateway_id      = aws_customer_gateway.s2s_cgw.id
  type                     = "ipsec.1"
  static_routes_only       = true
}


resource "aws_vpn_connection_route" "vpn_onprem_route" {
  vpn_connection_id      = aws_vpn_connection.s2s_vpn.id
  destination_cidr_block = var.onprem.ipv4_network_cidr
}

resource "aws_vpn_gateway_route_propagation" "vgw_route_propagation" {
  vpn_gateway_id = aws_vpn_gateway.s2s_vgw.id
  route_table_id = aws_route_table.s2s_private_rt.id
}