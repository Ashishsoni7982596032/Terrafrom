terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAROOZMHT5OGJ3FINJ"
  secret_key = "ejOXI17HFG5D60gnjwyehR7f3VsFTEnWZKzlh1vG"
}

resource "aws_vpc" "example" {
  cidr_block       = "10.0.12.0/27"
  instance_tenancy = "default"
}

resource "aws_subnet" "prod_web" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.12.0/28"
}
resource "aws_subnet" "prod_db" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.12.16/28"
}

resource "aws_security_group" "prod-ieco" {
  name   = "ieco-prod"
  vpc_id = aws_vpc.example.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.12.21/32"]
  }
}


resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.prod_db.id
  private_ips = ["10.0.12.21"] 
  security_groups = [aws_security_group.prod-ieco.id]
}

resource "aws_instance" "ieco-web" {
  ami           = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t2.micro"

 network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
}
