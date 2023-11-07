resource "aws_lb" "example" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_id

  tags = {
    Environment = "production"
  }
}
resource "aws_lb_target_group" "example" {
  name        = "example-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

resource "aws_lb_target_group_attachment" "attachments" {
  count            = length(var.ec2_instance_id)
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = var.ec2_instance_id[count.index]
  port             = 80
}