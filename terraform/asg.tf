resource "aws_launch_template" "ASG_template" {
  name          = "LaunchTemplateECR"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_group_names = [aws_security_group.ALB_to_containers.id]
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
  vpc_zone_identifier       = ["subnet-0dac9ab248dbb9596", "subnet-0a933dc6606abaeb0", "subnet-0ed459ed9dbe8e041"]
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