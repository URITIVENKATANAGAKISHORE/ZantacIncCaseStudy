// Merged AWS resources VPC and networking
resource "aws_vpc" "vpc_main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name = "${var.environment}-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.environment}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

// Security group
resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.vpc_main.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Custom Web Port"
    from_port   = var.web_server_port
    to_port     = var.web_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment}-web-sg"
  }
}

// Key pair and S3
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "key_bucket" {
  bucket        = "${var.environment}-ec2-key-bucket-${random_id.suffix.hex}"
  force_destroy = true
}

resource "aws_key_pair" "generated" {
  key_name   = "${var.environment}-ec2-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
  depends_on = [aws_s3_bucket.key_bucket]
}

resource "aws_s3_bucket_object" "pem_file" {
  bucket     = aws_s3_bucket.key_bucket.id
  key        = "${var.environment}-ec2-key.pem"
  content    = tls_private_key.ec2_key.private_key_pem
  depends_on = [aws_key_pair.generated]
}

// Launch template
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

// Auto Scaling Group
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

// IAM
resource "aws_iam_user" "web_restart" {
  name = var.iam_user_name
  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_policy" "restart_policy" {
  name        = "${var.environment}-restart-ec2"
  description = "Allow restart of EC2 instances in this environment"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:RebootInstances",
          "ec2:DescribeInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "web_restart_attach" {
  user       = aws_iam_user.web_restart.name
  policy_arn = aws_iam_policy.restart_policy.arn
}

// Application Load Balancer
resource "aws_lb" "web_lb" {
  name               = "${var.environment}-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public.id]
  tags = {
    Name = "${var.environment}-web-lb"
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "${var.environment}-web-tg"
  port     = var.web_server_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_main.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "${var.environment}-web-tg"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
