# VPC
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = var.tag_name
  }
}

# Subnet
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = var.tag_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = var.tag_name
  }
}

# Route Table
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = var.tag_name
  }
}

# Public Route
resource "aws_route" "public" {
  route_table_id         = aws_route_table.this.id
  gateway_id             = aws_internet_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}

# Relation Subnet and Route Table
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.this.id
}
