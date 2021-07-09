/*terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAROOZMHT5OGJ3FINJ"
  secret_key = "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"
}

resource "aws_vpc" "test" {
  cidr_block = "10.0.12.0/27"
  tags = {
    "Name" = "test"
  }
}

data "aws_vpc" "test" {
  id = var.vpc_id
}

resource "aws_subnet" "Public" {
  vpc_id     = data.aws_vpc.test.id
  cidr_block = "10.0.12.16/28"
  tags = {
    Name = "Public"
  }
}

resource "aws_security_group" "web-sg" {
  name   = "WEB-SG"
  vpc_id = data.aws_vpc.test.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.106.235.205/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "WEB-Server"
  }
}

resource "aws_network_interface" "Web-eni" {
  subnet_id       = aws_subnet.Public.id
  private_ips     = ["10.0.12.21"]
  security_groups = [aws_security_group.web-sg.id]
  tags = {
    Name = "Web-eni"
  }
}

data "aws_ami" "lnx2" {
  owners = ["self"]

  filter {
    name   = "name"
    values = ["amazon"]
  }
}


resource "aws_instance" "Web-server" {
  ami                         = data.aws_ami.lnx2.id
  instance_type               = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.Web-eni.id
    device_index         = 0
  }
}
*/