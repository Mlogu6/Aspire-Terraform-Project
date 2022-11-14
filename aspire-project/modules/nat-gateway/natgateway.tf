#create a eip to allocate it with nat gateway in az1
resource "aws_eip" "aspire-hyd-eip-az1" {
  vpc      = true

  tags = {
    Name = "${var.project_name}-az1-eip"
  }

}

#create a eip to allocate it with nat gateway in az2
resource "aws_eip" "aspire-hyd-eip-az2" {
  vpc      = true

  tags = {
    Name = "${var.project_name}-az2-eip"
  }

}

#create a nat gateway in az1
resource "aws_nat_gateway" "aspire-hyd-nat-gateway-az1" {
  allocation_id = aws_eip.aspire-hyd-eip-az1.id
  subnet_id     = var.public_subnet_az1_id

  tags = {
    Name = "${var.project_name}-nat-gateway-az1"
  }

  # ensure proper ordering
  depends_on = [var.internet_gateway]

}

  #create a nat gateway in az2
  resource "aws_nat_gateway" "aspire-hyd-nat-gateway-az2" {
  allocation_id = aws_eip.aspire-hyd-eip-az2.id
  subnet_id     = var.public_subnet_az2_id

  tags = {
    Name = "${var.project_name}-nat-gateway-az2"
  }

  # ensure proper ordering
  depends_on = [var.internet_gateway]

}

#create a private route table for az1
resource "aws_route_table" "aspire_hyd_rt_private_az1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.routetable_cidr
    nat_gateway_id = aws_nat_gateway.aspire-hyd-nat-gateway-az1.id
  }

  tags = {
    Name = "${var.project_name}-rt-private-az1"
  }

}

#create a private route table for az2
resource "aws_route_table" "aspire_hyd_rt_private_az2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.routetable_cidr
    nat_gateway_id = aws_nat_gateway.aspire-hyd-nat-gateway-az2.id
  }

  tags = {
    Name = "${var.project_name}-rt-private-az2"
  }

}

# associate private rt with priavte app subnet in az1
resource "aws_route_table_association" "aspire_hyd_private_app_az1_rt_association" {
  subnet_id      = var.private_subnet_app_az1_id
  route_table_id = aws_route_table.aspire_hyd_rt_private_az1.id
}

# associate private rt with priavte app subnet in az2
resource "aws_route_table_association" "aspire_hyd_private_app_az2_rt_association" {
  subnet_id      = var.private_subnet_app_az2_id
  route_table_id = aws_route_table.aspire_hyd_rt_private_az2.id
}

# associate private rt with priavte data subnet in az1
resource "aws_route_table_association" "aspire_hyd_private_data_az1_rt_association" {
  subnet_id      = var.private_subnet_data_az1_id
  route_table_id = aws_route_table.aspire_hyd_rt_private_az1.id
}

# associate private rt with priavte data subnet in az1
resource "aws_route_table_association" "aspire_hyd_private_data_az2_rt_association" {
  subnet_id      = var.private_subnet_data_az2_id
  route_table_id = aws_route_table.aspire_hyd_rt_private_az2.id
}