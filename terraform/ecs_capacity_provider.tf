resource "aws_ecs_capacity_provider" "test" {
  name = "ProviderEC2Container"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ASG_config.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.fastapi-cluster.name

  capacity_providers = ["ProviderEC2Container"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "ProviderEC2Container"
  }
}


