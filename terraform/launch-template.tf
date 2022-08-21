resource "aws_launch_template" "back_end" {
	name 					= "lt-my-app"

	instance_type 				= "t2.micro"

	image_id 				= "ami-0a1ee2fb28fe05df3"

	instance_initiated_shutdown_behavior 	= "terminate"

	update_default_version 			= true

	key_name 				= "<your_key>"

	network_interfaces {
	associate_public_ip_address 		= true

	security_groups 			= [
			aws_security_group.ec2-sg.id,
      			aws_security_group.ssh.id
		]
	}

	placement {availability_zone 		= "eu-central-1"}

	tag_specifications {
		resource_type 			= "instance"
		tags 				= {
		Name   				= "back-end"
		}
	}
		user_data 			= file("install_nginx.sh")
}
