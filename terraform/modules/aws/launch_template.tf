resource "aws_launch_template" "web" {
  name_prefix   = "${var.environment}-web-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated.key_name
  network_interfaces {
    associate_public_ip_address = true
    subnet_id                  = aws_subnet.public.id
    security_groups            = [aws_security_group.web_sg.id]
  }
  user_data = var.user_data
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.environment}-web"
      Environment = var.environment
    }
  }
}
