terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.93.0"
    }
  }
  backend "s3" {
    bucket = "demo-bucket-46cf195816cc6f32"
    key = "backend.tfstate"
    region = "ap-south-1"    
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}


resource "aws_instance" "myserver" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"

  tags = {
    Name = "sampleserver"
  }
}
