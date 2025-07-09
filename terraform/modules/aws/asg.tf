resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier   = [aws_subnet.public.id]
  desired_capacity      = var.asg_desired
  max_size             = var.asg_max
  min_size             = var.asg_min
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "${var.environment}-web-asg"
    propagate_at_launch = true
  }
}
