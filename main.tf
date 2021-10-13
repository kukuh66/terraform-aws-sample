provider "aws"{
    region  = "us-east-1"
}
resource "aws_instance" "sample1" {
    ami                     ="ami-09e67e426f25ce0d7"
    instance_type           ="t2.micro" 
    vpc_security_group_ids  = [aws_security_group.instance.id]

# used for install simple web server
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World " > index.html
                nohup busybox httpd -f -p "$(var.server_port)" &
                EOF

    tags = {
        Name = "tf-example"
    }
}

# COMMAND CREATE SECURITY GROUP

resource "aws_security_group" "instance"{
    name = "tf-example-instance"

    # allow Inbound for Anywhere
    ingress {
        from_port   = var.server_port
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}