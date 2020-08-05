
# Creating Main VPC FootGo
resource "aws_vpc" "footgo_vpc" {
  cidr_block = var.v_main_vpc
  tags = {
    Name = "FootGo VPC"
  }
}

# Creating first Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.footgo_vpc.id
  cidr_block        = var.v_private_subnet
  availability_zone = var.v_availability_zone

  tags = {
    Name = "Private Subnet"
  }
}
# Creating second Private subnet
resource "aws_subnet" "s_private_subnet" {
  vpc_id            = aws_vpc.footgo_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Private Subnet"
  }
}

# Creating Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.footgo_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Public Subnet"
  }
}

# Creating Internet Gateway for VPC Footgo

resource "aws_internet_gateway" "footgo_gw" {
  vpc_id = aws_vpc.footgo_vpc.id

  tags = {
    Name = "Footgo gateway"
  }
}

#Creating Elastic IP
resource "aws_eip" "footgo_eip" {
  vpc = true
  tags = {
    Name = "Footgo_EIP"
  }
}
#Creating NAT gateway for Private subnet
resource "aws_nat_gateway" "footgo_nat_gw" {
  allocation_id = aws_eip.footgo_eip.id
  subnet_id     = aws_subnet.private_subnet.id
  tags = {
    Name = "NAT for Private subnet"
  }
}
#Creating Main route table
resource "aws_route_table" "main_route" {
  vpc_id = aws_vpc.footgo_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.footgo_nat_gw.id
  }

  tags = {
    Name = "Main route"
  }
}
#Main route table associations to Private subnet
resource "aws_route_table_association" "Private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.main_route.id
}



#Creating Custom route table
resource "aws_route_table" "custom_route" {
  vpc_id = aws_vpc.footgo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.footgo_gw.id
  }

  tags = {
    Name = "Custom route"
  }
}

#Costom route table associations to Private subnet
resource "aws_route_table_association" "Public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.custom_route.id
}
