resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "two-tier-igw" {
  tags = {
    Name = "two-tier-igw"
  }
  vpc_id = aws_vpc.main.id
}

# Route Table
resource "aws_route_table" "two-tier-rt" {
  tags = {
    Name = "two-tier-rt"
  }
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.two-tier-igw.id
  }
}
