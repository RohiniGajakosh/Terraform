provider "aws" {
  region = "ap-south-1"
}

#key_value pair
resource "aws_key_pair" "deployerkey" {
  key_name   = "generaterdkey"
  public_key = file("~/.ssh/generatekey.pub")
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}

resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my_public_subnet"
  }
}
resource "aws_route_table_association" "mypublicrt" {
  subnet_id      = aws_subnet.my_public_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}
resource "aws_security_group" "mysg" {
  name        = "mysg"
  description = "my security group"
  vpc_id      = aws_vpc.my_vpc.id

  #inbound rule
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow SSH access"
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow HTTP access"
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow HTTPS access"
  }

  #outbound rule
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all outbound traffic"
  }
  tags = {
    Name = "mysg"
  }
}

resource "aws_instance" "myec2" {
  count = 2
  ami                         = var.ami_id 
  subnet_id                   = aws_subnet.my_public_subnet.id
  key_name                    = aws_key_pair.deployerkey.key_name
  vpc_security_group_ids      = [aws_security_group.mysg.id]
  associate_public_ip_address = true
  instance_type               = var.instance_type
  user_data                   = file("shell.sh")
  
  root_block_device {
    volume_size = var.ec2_root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = "myec2instance"
  }

}

# resource "aws_iam_instance_profile" "name" {

# }

