provider "aws" {
  region = "us-east-2"
  profile = "cicd-profile"
}

resource "aws_default_vpc" "default_vpc" {
  
  tags = {
    Name = "default_vpc"
    Project = "propio"
  }
}

data "aws_availability_zones" "available_zones" {
}

resource "aws_default_subnet" "default_az1" {
    availability_zone = data.aws_availability_zones.available_zones
 tags = {
    Name = "default_az1"
    Project = "propio"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instances allowing access on port 22 and 80"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }
egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0/0"]
  }

tags = {
    Name = "ec2_security_group"
    Project = "propio"
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id     = aws_default_subnet.default_az1.id
  security_groups = [aws_security_group.ec2_security_group.id]
  key_name = "my-key-pair"

  tags = {
    Name = "ec2_instance"
    Project = "propio"
  }
}

output "ec2_instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}