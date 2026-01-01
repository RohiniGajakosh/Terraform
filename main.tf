
#key_value pair
resource "aws_key_pair" "deployerkey" {
  key_name   = "generaterdkey"
  public_key = file("~/.ssh/generatekey.pub")
}

# resource "aws_vpc" "my_vpc" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   tags = {
#     Name = "my_vpc"
#   }
# }

# resource "aws_internet_gateway" "my_igw" {
#   vpc_id = aws_vpc.my_vpc.id
#   tags = {
#     Name = "my_igw"
  
#   }
# }

# resource "aws_subnet" "my_public_subnet" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = "ap-south-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "my_public_subnet"
#   }
# }
# resource "aws_route_table_association" "mypublicrt" {
#   subnet_id      = aws_subnet.my_public_subnet.id
#   route_table_id = aws_route_table.my_route_table.id
# }

# resource "aws_route_table" "my_route_table" {
#   vpc_id = aws_vpc.my_vpc.id
#   tags = {
#     Name = "my_route_table"
#   }
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.my_igw.id
#   }
# }
# resource "aws_security_group" "mysg" {
#   name        = "mysg"
#   description = "my security group"
#   vpc_id      = aws_vpc.my_vpc.id

#   #inbound rule
#   ingress {
#     from_port   = "22"
#     to_port     = "22"
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "allow SSH access"
#   }
#   ingress {
#     from_port   = "80"
#     to_port     = "80"
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "allow HTTP access"
#   }
#   ingress {
#     from_port   = "443"
#     to_port     = "443"
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "allow HTTPS access"
#   }

#   #outbound rule
#   egress {
#     from_port   = "0"
#     to_port     = "0"
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "allow all outbound traffic"
#   }
#   tags = {
#     Name = "mysg"
#   }
# }

# resource "aws_instance" "myec2" {
#   #count = 2 #to create multiple instances with same configuration
#   for_each = tomap({
#     "myec2instance1" = "Instance 1"
#     "myec2instance2" = "Instance 2"
#   })
#   ami                         = var.ami_id 
#   subnet_id                   = aws_subnet.my_public_subnet.id
#   key_name                    = aws_key_pair.deployerkey.key_name
#   vpc_security_group_ids      = [aws_security_group.mysg.id]
#   associate_public_ip_address = true
#   instance_type               = var.instance_type
#   user_data                   = file("shell.sh")
#   iam_instance_profile        = aws_iam_instance_profile.SSM_Instance_Profile.name
  
  
#   root_block_device {
#     volume_size = var.env == "prod" ? var.ec2_root_volume_size : 16
#     volume_type = "gp3"
#   }

#   tags = {
#     Name = "${each.key}"
#     Environment = var.env
#   }

# }
resource "random_id" "bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "maabucket" {
  bucket = "rohinibucket-${random_id.bucket_id.hex}"
}

resource "aws_s3_object" "bucket_object" {
  bucket = aws_s3_bucket.maabucket.id
  key    = "files/shell.sh"  #path in the bucket
  source = "shell.sh" #local path of the file to be uploaded
  etag   = filemd5("shell.sh") #to check if the file has changed

  }
# resource "aws_iam_role" "SSM_role" {
#   name = "SSM_Role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   }) 
# }

# resource "aws_iam_role_policy_attachment" "ssm_policy" {
#   role       = aws_iam_role.SSM_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }
# resource "aws_iam_instance_profile" "SSM_Instance_Profile" {
#   name = "SSM_Instance_Profile"
#   role = aws_iam_role.SSM_role.name
# }

# IAM Policy for SSM to allow EC2 Describe actions like DescribeInstances
# resource "aws_iam_policy" "SSM_Policy" {
#   name        = "SSM_Policy"
#   description = "My SSM policy for EC2 instances"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_key_pair" "awskey" {
#   key_name   = "awskey"
#   public_key = file("~/.ssh/awskey.pem")
# }
# import {
#   to = aws_key_pair.awskey
#   id = "key-084942ac68bca7a0f"
# }

# resource "aws_vpc" "imported_vpc" {
#   # Configuration will be imported
  
# }
# import {
#   to = aws_vpc.importvpc
#   id = "vpc-0625e051be2b024e9"
# }