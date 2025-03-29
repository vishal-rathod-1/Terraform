output "instance_public_ip" {
description = "The public IP address of the EC2 instance"
value= aws_instance.myserver.public_ip
}



output "instance_url" {
description = "The URL to access the Nginx server"
value= "http://${aws_instance.myserver.public_ip}"
}