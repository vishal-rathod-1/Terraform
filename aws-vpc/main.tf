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
  region= "ap-south-1"
}

#create a vpc
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }  
}
# create a private subnet
resource "aws_subnet" "private_subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id 
    tags = {
        Name = "private subnet"
    }
}


# create a public subnet
resource "aws_subnet" "public_subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id 
    tags = {
        Name = "public subnet"
    }
}

#internet gateway
resource "aws_internet_gateway" "igway" {
         vpc_id = aws_vpc.my-vpc.id 
        tags = {
            Name = " My internet gateway"
        }
}

#routing table

resource "aws_route_table" "routing" {
    vpc_id=aws_vpc.my-vpc.id  
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igway.id
    }
}
# associating public subnet to internet gateway
resource "aws_route_table_association" "public_subnet" {
      subnet_id = aws_subnet.public_subnet.id 
      route_table_id = aws_route_table.routing.id

}

#create ec2 in private
resource "aws_instance" "myserver" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "sampleserver"
  }
}