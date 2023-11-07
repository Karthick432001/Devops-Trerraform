output "lb_sg_id" {
  value = aws_security_group.lb-sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.two-tier-ec2-sg.id
}