resource "aws_lb" "public_alb" {
	name 		       		= "public-alb"
	internal 			= false
	load_balancer_type 		= "application"

	security_groups 		= [aws_security_group.ec2-sg.id]

	subnets 			= ["subnet-0be6c6316018feb5d","subnet-01c6e6c74756bdee3"]

	enable_deletion_protection 	= false

	tags 				= {
	Name 				= "public alb"
	Environment 			= "test"
	}
}

resource "aws_lb_listener" "http" {
	load_balancer_arn 		= aws_lb.public_alb.arn
	port 				= 80

	default_action {
		type 			= "fixed-response"

		fixed_response {
			content_type 	= "text/plain"
			message_body 	= "There's nothing here"
			status_code  	= "404"
		}
	}
}

resource "aws_lb_listener_rule" "back_end" {
	listener_arn 			= aws_lb_listener.http.arn

	action {
		type 			= "forward"
		target_group_arn 	= aws_lb_target_group.back_end.arn
	}

	condition {
		host_header {
			values 		= ["api.example.com"]
		}
	}
}

resource "aws_lb_target_group" "back_end" {
	vpc_id   			= "vpc-08f3eea99feedf17c"
	name 	 			= "back_end_tg"
	port 	 			= 80
	protocol 			= "HTTP"
}
