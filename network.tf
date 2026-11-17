resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "Ankush_vpc"
  }
  enable_dns_support   = true
  enable_dns_hostnames = true
}


resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"

  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Ankush_public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"

  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Ankush_public_b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.11.0/24"

  availability_zone = "us-east-2a"
  tags = {
    Name = "Ankush_private_a"
  }
}


resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "Ankush_private_b"
  }
}