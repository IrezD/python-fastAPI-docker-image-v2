resource "aws_lb" "alb" {
  name               = "fastapi-lb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internet_to_ALB.id]
  subnets            = var.subnets_for_ecs
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_P-5000.arn
  }
}

resource "aws_lb_target_group" "target_group_P-5000" {
  name        = "alb-target-group-${var.env}"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}