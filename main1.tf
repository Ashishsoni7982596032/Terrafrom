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

locals {
  tags = {
    "Name" = "test-env"
  }
}

resource "aws_vpc" "IECO" {
  cidr_block = "10.0.12.0/27"
  tags       = local.tags
}

resource "aws_subnet" "Web" {
  vpc_id     = aws_vpc.IECO.id
  cidr_block = "10.0.12.0/28"

  tags = local.tags
}

resource "aws_security_group" "web-sg" {
  name   = "Web-SG"
  vpc_id = aws_vpc.IECO.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.12.10/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}

resource "aws_network_interface" "IECO-Web-Server" {
  subnet_id       = aws_subnet.Web.id
  private_ips     = ["10.0.12.10"]
  security_groups = [aws_security_group.web-sg.id]
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name      = "name"
    values    = ["amazon"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  tags          = local.tags

 network_interface {
    network_interface_id = aws_network_interface.IECO-Web-Server.id
    device_index         = 0
  }
}*/