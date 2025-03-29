resource "aws_security_group" "nginx" {
    vpc_id=aws_vpc.my-vpc.id
#inbound rules
    ingress {
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
    } 
#outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "nginx-sg"
    }

}