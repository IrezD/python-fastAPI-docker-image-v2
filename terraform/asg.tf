resource "aws_launch_template" "ASG_template" {
  name          = "LaunchTemplateECR"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ALB_to_containers.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }
}

resource "aws_autoscaling_group" "ASG_config" {
  name                      = "fastapi-ASG-${var.env}"
  desired_capacity_type = "units"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier  = [var.subnets_for_ecs]
  launch_template {
    id = aws_launch_template.ASG_template.id
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

}