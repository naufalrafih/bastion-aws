provider "aws" {
  region = var.region
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key-${var.environment}"
  public_key = tls_private_key.private_key.public_key_openssh
  tags = {
    "Name" = "bastion-key-${var.environment}"
    "env"  = var.environment
  }
}

resource "local_file" "private_key" {
  depends_on = [
    tls_private_key.private_key,
  ]
  content         = tls_private_key.private_key.private_key_pem
  filename        = var.private_key_path
  file_permission = "600"
}

resource "aws_vpc" "bastion_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "bastion-vpc-${var.environment}"
    "env"  = var.environment
  }
}

resource "aws_subnet" "bastion_subnet" {
  vpc_id                  = aws_vpc.bastion_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "bastion-subnet-${var.environment}"
    "env"  = var.environment
  }
}

resource "aws_internet_gateway" "bastion_vpc_gateway" {
  vpc_id = aws_vpc.bastion_vpc.id
  tags = {
    Name  = "bastion-gw-${var.environment}"
    "env" = var.environment
  }
}

resource "aws_route_table" "bastion_vpc_route_table" {
  vpc_id = aws_vpc.bastion_vpc.id
  tags = {
    Name  = "bastion-route-table-${var.environment}"
    "env" = var.environment
  }
}

resource "aws_route" "bastion_vpc_internet_access" {
  route_table_id         = aws_route_table.bastion_vpc_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.bastion_vpc_gateway.id
}

resource "aws_route_table_association" "bastion_vpc_association" {
  subnet_id      = aws_subnet.bastion_subnet.id
  route_table_id = aws_route_table.bastion_vpc_route_table.id
}

resource "aws_security_group" "bastion_sg" {
  depends_on = [aws_subnet.bastion_subnet]
  name       = "bastion-sg-${var.environment}"
  vpc_id     = aws_vpc.bastion_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = var.sg_port
    to_port     = var.sg_port
    cidr_blocks = [var.sg_cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "bastion-sg-${var.environment}"
    "env"  = var.environment
  }
}

resource "aws_instance" "bastion_host" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.bastion_subnet.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = "bastion-key-${var.environment}"
  associate_public_ip_address = true
  tags = {
    "Name" = "bastion-host-${var.environment}"
    "env"  = var.environment
  }
}