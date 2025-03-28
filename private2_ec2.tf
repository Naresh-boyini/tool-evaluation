# private1 ec2 instance

resource "aws_instance" "deploy_ec2_private2_instance" {
  ami           = "ami-0607a9783dd204cae"
  instance_type = "t3.large"

  network_interface {
    network_interface_id = aws_network_interface.deploy_private2_network_interface.id
    device_index         = 0
  }

  key_name = "infra"

  tags = {
    Name = "kibana2"
  }

  # associate_public_ip_address = false
}

# network interface

resource "aws_network_interface" "deploy_private2_network_interface" {
  subnet_id = aws_subnet.deploy_subnet_private2.id
  #   private_ips = ["172.16.10.100"]
  security_groups = [aws_security_group.web_server_sg_private2_tf.id]
  tags = {
    Name = "deploy_private2_network_interface"
  }
}

# instance in public subnet
resource "aws_security_group" "web_server_sg_private2_tf" {
  name        = "web-server-sg-private2-tf"
  description = "Allow HTTPS to web server"
  vpc_id      = aws_vpc.deploy_vpc.id

  ingress {
    description = "ssh ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "All traffic ingress"
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    description = "All traffic ingress"
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
  from_port   = 5601
  to_port     = 5601
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
}
