terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Configure AWS VPC creation
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC"
  }
}

# Configure AWS VPC public subnet creation
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Name = "Pub"
  }
}

# Configure internet gateway creation
resource "aws_internet_gateway" "terraform_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "int-gw"
  }
}

# Configure public Route table creation
resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_gw.id
  }

  tags = {
    Name = "pub-rt"
  }
}

# Configure Route table associate to subnet
resource "aws_route_table_association" "assroute" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.pub-route-table.id
}

# Configure AWS VPC private subnet creation
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Pri"
  }
}

#Create an Elastic ip
resource "aws_eip" "eip" {
  domain   = "vpc"
}

#Create a NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT-gw"
  }
}

# Configure Private Route table creation
resource "aws_route_table" "pri-route-table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "pri-rt"
  }
}

# Configure Route table associate to subnet
resource "aws_route_table_association" "ass-pri-route" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.pri-route-table.id
}

# Configure Security group
resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "SSH-linux"
  }
}

# Configure ingress rule
resource "aws_vpc_security_group_ingress_rule" "ssh_ipv4" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  ip_protocol       = "ssh"
  to_port           = 22
}

# Create EC2 instance1
resource "aws_instance" "server1" {
  ami                           = "ami-0a75bd84854bc95c9"
  instance_type                 = "t2.micro"
  subnet_id                     = aws_subnet.public.id
  aws_vpc_security_group_ids    = ["aws_security_group.ssh.id"]
  key_name                      = "Gv"
  associate_public_ip_address   = true

  tags = {
    Name = "ubuntu1"
  }
}

# Create EC2 instance2
resource "aws_instance" "server2" {
  ami                           = "ami-0a75bd84854bc95c9"
  instance_type                 = "t2.micro"
  subnet_id                     = aws_subnet.private.id
  aws_vpc_security_group_ids    = ["aws_security_group.ssh.id"]
  key_name                      = "Gv"

  tags = {
    Name = "ubuntu2"
  }
}