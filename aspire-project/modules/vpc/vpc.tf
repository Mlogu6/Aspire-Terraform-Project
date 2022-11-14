# creating vpc
resource "aws_vpc" "aspire_hyd_vpc" {
  cidr_block           = var.cidr[0]
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
    Team = var.team
  }

}


# creating the Internet Gateway
resource "aws_internet_gateway" "aspire_hyd_igw" {
  vpc_id = aws_vpc.aspire_hyd_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
    Team = var.team
  }

}

# use data source to use all availability zone and map with index

data "aws_availability_zones" "availabe_zones" {}

# creating public subnet in az1
resource "aws_subnet" "aspire_hyd_public_subnet_az1" {
  cidr_block              = var.cidr[1]
  vpc_id                  = aws_vpc.aspire_hyd_vpc.id
  availability_zone       = data.aws_availability_zones.availabe_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-az1"
    Team = var.team
  }

}

# creating public subnet in az2
resource "aws_subnet" "aspire_hyd_public_subnet_az2" {
  cidr_block              = var.cidr[2]
  vpc_id                  = aws_vpc.aspire_hyd_vpc.id
  availability_zone       = data.aws_availability_zones.availabe_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-az2"
    Team = var.team
  }

}

#create route table for public subnet
resource "aws_route_table" "aspire_hyd_rt" {
  vpc_id = aws_vpc.aspire_hyd_vpc.id

  route {
    cidr_block = var.routetable_cidr
    gateway_id = aws_internet_gateway.aspire_hyd_igw.id
  }

  tags = {
    Name = "${var.project_name}-rt"
    Team = var.team
  }

}

# assosiate route table with public subnet az1
resource "aws_route_table_association" "aspire_hyd_public_az1_rt_association" {
  subnet_id      = aws_subnet.aspire_hyd_public_subnet_az1.id
  route_table_id = aws_route_table.aspire_hyd_rt.id
}

# assosiate route table with public subnet az2
resource "aws_route_table_association" "aspire_hyd_public_az2_rt_association" {
  subnet_id      = aws_subnet.aspire_hyd_public_subnet_az2.id
  route_table_id = aws_route_table.aspire_hyd_rt.id
}

# creating private app subnet in az1
resource "aws_subnet" "aspire_hyd_private_subnet_app_az1" {
  cidr_block              = var.cidr[3]
  vpc_id                  = aws_vpc.aspire_hyd_vpc.id
  availability_zone       = data.aws_availability_zones.availabe_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-app-az1"
    Team = var.team
  }

}

# creating private app subnet in az2
resource "aws_subnet" "aspire_hyd_private_subnet_app_az2" {
  cidr_block              = var.cidr[4]
  vpc_id                  = aws_vpc.aspire_hyd_vpc.id
  availability_zone       = data.aws_availability_zones.availabe_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-app-az2"
    Team = var.team
  }

}

# creating private data subnet in az1
resource "aws_subnet" "aspire_hyd_private_subnet_data_az1" {
  cidr_block              = var.cidr[5]
  vpc_id                  = aws_vpc.aspire_hyd_vpc.id
  availability_zone       = data.aws_availability_zones.availabe_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-data-az1"
    Team = var.team
  }

}

# creating private data subnet in az2
resource "aws_subnet" "aspire_hyd_private_subnet_data_az2" {
  cidr_block              = var.cidr[6]
  vpc_id                  = aws_vpc.aspire_hyd_vpc.id
  availability_zone       = data.aws_availability_zones.availabe_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-data-az2"
    Team = var.team
  }

}
