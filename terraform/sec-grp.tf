resource "aws_security_group" "ec2-sg" {

	name = "${var.product}.${var.environment}-ec2-sg"

    	vpc_id = "vpc-08f3eea99feedf17c"

	ingress {
		from_port   = 5000
		to_port     = 5000
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 65535
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port 	= 0
		to_port 	= 65535
		protocol    	= "UDP"
		cidr_blocks 	= ["0.0.0.0/0"]
	}

	description =  "Allows access to port 80 from Internet"

	tags = {
		Name = "ec2-sg"
	}
}

resource "aws_security_group" "ssh" {
	name = "tf-ssh"

	ingress {
		from_port 	= 22
		protocol 	= "TCP"
		to_port 	= 22
		cidr_blocks = ["<your_public_ip>/32"]
	}

	description = "Allows access to 22 port from Internet"

	tags = {
		Name = "ssh-sg"
	}
}
