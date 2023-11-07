output "ec2_instance_id" {
  value = aws_instance.two-tier-web-server[*].id
}