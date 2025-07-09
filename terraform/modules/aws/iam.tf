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
