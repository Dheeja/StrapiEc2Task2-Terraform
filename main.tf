provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "strapi-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "strapi-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "strapi-public-subnet"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "strapi-public-rt"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 

# EC2 Instance
resource "aws_instance" "strapi_ec2" {
  ami                    = "ami-0e449927258d45bc4" # Amazon Linux 2
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.public.id
  key_name               = "Momos" # Replace with your actual key pair
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh_web.id]
  user_data              = file("setup.sh")

  tags = {
    Name = "StrapiTerraformEC2"
  }
}
