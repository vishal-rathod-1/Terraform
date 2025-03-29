resource "aws_instance" "myserver" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
user_data = <<-EOF
#!/bin/bash
yum install -y nginx
systemctl start nginx
systemctl enable nginx
EOF

vpc_security_group_ids = [ aws_security_group.nginx.id ]
associate_public_ip_address = true

  tags = {
    Name = "Nginxserver"
  }
}