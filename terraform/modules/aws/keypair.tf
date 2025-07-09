# Key pair generation and S3 storage (used by launch_template)
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
