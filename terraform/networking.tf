resource "aws_security_group" "internet_to_ALB" {
  name        = "internet-to-alb-${var.env}"
  description = "Inbound traffic from the internet into ALB for ${var.env} FastAPI environment"

  ingress {
    description      = "Allowing https traffic to ALB from the internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allowing http traffic to ALB from the internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "ALB_to_containers" {
  name        = "alb-to-containers-${var.env}"
  description = "Allowing traffic from ALB to containers for ${var.env} FastAPI environment"

  ingress {
    description     = "Inbound ALB to ECS containers"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.internet_to_ALB.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}