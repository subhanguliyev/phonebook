resource "aws_instance" "ec2" {
  	ami 			= var.ami
  	instance_type 		= var.ec2_class
  	vpc_security_group_ids 	= [aws_security_group.ec2-sg.id]

  	tags 			= {
      	Name 			= "${var.product}.${var.environment}-ec2"
  }
}
resource "aws_iam_instance_profile" "ec2_profile" {
    	name 			= "${var.product}.${var.environment}-ec2-profile"
    	role 			= aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  	name 			= "server-role"

  	path 			= "/"

  	assume_role_policy 	= <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

