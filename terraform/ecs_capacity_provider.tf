resource "aws_ecs_capacity_provider" "customProvider" {
  name = "CustomEC2Provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ASG_config.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "Provider_config" {
  cluster_name = aws_ecs_cluster.fastapi-cluster.name

  capacity_providers = ["CustomEC2Provider"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "CustomEC2Provider"
  }
}


