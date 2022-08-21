resource "aws_autoscaling_group" "back_end" {
	name = "back_end_asg"

	availability_zones 	= [
    	"eu-central-1a",
    	"eu-central-1b"
  	]

  	desired_capacity 	= 4
  	max_size 		= 10
  	min_size 		= 2

  	target_group_arns 	= [
  		aws_lb_target_group.back_end.arn
  	]

  	health_check_grace_period 	= 300

  	protect_from_scale_in 		= false

  	launch_template {
  	id      			= aws_launch_template.back_end.id
    	version 			= "$Latest"
  	}

  	tag {
  		key 				= "asg"
  		propagate_at_launch = true
  		value 				= "back_end"
  	}
}

resource "aws_autoscaling_policy" "back_end_scale_app" {
	name 		= "requests_count_scaling_policy"
	policy_type 	= "TargetTrackingScaling"

	autoscaling_group_name = aws_autoscaling_group.back_end.name

	target_tracking_configuration {
		predefined_metric_specification {
			predefined_metric_type = "ALBRequestCountPerTarget"
			resource_label = format("%s/%s", aws_lb.pubic_alb.arn_suffix, aws_lb_target_group.back_end.arn_suffix)
		}

		target_value = 30
	}
}
