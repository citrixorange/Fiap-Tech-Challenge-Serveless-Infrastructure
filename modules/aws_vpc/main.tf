# Define VPC
resource "aws_vpc" "fiap_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.fiap_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Create private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.fiap_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "fiap_internet_gateway" {
  vpc_id = aws_vpc.fiap_vpc.id
}

resource "aws_eip" "fiap_eip" {
  vpc = true
}

resource "aws_nat_gateway" "fiap_nat_gateway" {
  allocation_id = aws_eip.fiap_eip.id
  subnet_id     = aws_subnet.public.id
}

# Define route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.fiap_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fiap_internet_gateway.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.fiap_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.fiap_nat_gateway.id
  }
}

# Associate subnets with route tables
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}