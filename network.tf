resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "Ankush_vpc"
  }
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Ankush_def_secgroup"
  }
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


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Ankush_igw"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "Ankush_public_route_table"
  }
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id



  tags = {
    Name = "Ankush_private_route_table"
  }
}


resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_route_table.id
}
