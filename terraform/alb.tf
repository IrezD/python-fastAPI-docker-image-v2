resource "aws_lb" "alb" {
  name               = "fastapi-lb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internet_to_ALB.id]
  subnets            = var.subnets_for_ecs
}

resource "aws_lb_listener" "listerner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "alb-target-group-${var.env}"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "asg_lb_association" {
  autoscaling_group_name = aws_autoscaling_group.ASG_config.id
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}
 