terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region= var.region

}

resource "aws_instance" "myserver" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"

  tags = {
    Name = "sampleserver"
  }
}