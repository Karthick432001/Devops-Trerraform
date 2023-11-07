resource "aws_subnet" "public_subnets" {
  count             = length(var.public_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = format("%s-%d", var.public_subnet_name, count.index)
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = format("%s-%d", var.private_subnet_name, count.index)
  }
}

#route table association 
resource "aws_route_table_association" "rt_as" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = var.route_table_id
}

resource "aws_db_subnet_group" "two-tier-db-sub" {
  name       = "two-tier-db-sub"
  subnet_ids = aws_subnet.private_subnets[*].id
}
