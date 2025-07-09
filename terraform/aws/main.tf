module "aws" {
  source      = "../modules/aws"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  web_server_port    = var.web_server_port
  ssh_cidr           = var.ssh_cidr
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  user_data          = var.user_data
  asg_desired        = var.asg_desired
  asg_max            = var.asg_max
  asg_min            = var.asg_min
  iam_user_name      = var.iam_user_name
}
