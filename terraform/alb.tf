resource "aws_lb" "alb" {
  name               = "fastapi-lb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internet_to_ALB.id]
  subnets            = var.subnets_for_ecs
}

resource "aws_lb_listener" "listerner_80" {
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

resource "aws_lb_listener" "listerner_443" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_P-5001.arn
  }
}

resource "aws_lb_target_group" "target_group_P-5001" {
  name        = "alb-target-group-${var.env}"
  port        = 5000
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_lb_listener.listerner_443.arn
  certificate_arn = "arn:aws:acm:us-east-1:806066816337:certificate/3848def8-0982-4f7e-b2be-664c6d00d101"
}