output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web_lb.dns_name
}

output "s3_pem_file_url" {
  description = "S3 URL for the EC2 PEM file"
  value       = aws_s3_bucket_object.pem_file.id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_asg.name
}

output "iam_user_arn" {
  description = "ARN of the IAM user allowed to restart EC2 instances"
  value       = aws_iam_user.web_restart.arn
}
