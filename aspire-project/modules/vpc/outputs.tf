output "cidr" {
  value = var.cidr
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.aspire_hyd_vpc.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.aspire_hyd_public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.aspire_hyd_public_subnet_az2.id
}

output "private_subnet_app_az1_id" {
  value = aws_subnet.aspire_hyd_private_subnet_app_az1.id
}

output "private_subnet_app_az2_id" {
  value = aws_subnet.aspire_hyd_private_subnet_app_az2.id
}

output "private_subnet_data_az1_id" {
  value = aws_subnet.aspire_hyd_private_subnet_app_az1.id
}

output "private_subnet_data_az2_id" {
  value = aws_subnet.aspire_hyd_private_subnet_app_az2.id
}

output "internet_gateway" {
  value = aws_internet_gateway.aspire_hyd_igw.id
}




