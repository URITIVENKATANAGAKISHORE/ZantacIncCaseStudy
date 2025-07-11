variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}
variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}
variable "availability_zone" {
  type        = string
  description = "AWS Availability Zone for resources"
}
variable "web_server_port" {
  type        = number
  description = "Port number for the web server"
}
variable "ssh_cidr" {
  type        = string
  description = "CIDR block allowed to SSH into instances"
}
variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instances"
}
variable "instance_type" {
  type        = string
  description = "EC2 instance type (e.g., t2.micro)"
}
variable "key_name" {
  type        = string
  description = "Name of the SSH key pair"
}
variable "user_data" {
  type        = string
  description = "User data script for EC2 initialization"
}
variable "asg_desired" {
  type        = number
  description = "Desired number of instances in Auto Scaling Group"
}
variable "asg_max" {
  type        = number
  description = "Maximum number of instances in Auto Scaling Group"
}
variable "asg_min" {
  type        = number
  description = "Minimum number of instances in Auto Scaling Group"
}
variable "iam_user_name" {
  type        = string
  description = "Name of the IAM user"
}
