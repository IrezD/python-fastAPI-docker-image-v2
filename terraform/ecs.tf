# ------ ECS Cluster ------- **

resource "aws_ecs_cluster" "fastapi-cluster" {
  name = "fastapi-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
}

# ------ Task definition ------- ** 

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.env}-fastapi-container"
  requires_compatibilities = ["EC2"]
  container_definitions    = "${file("scripts/task_definition.json")}"
}

# ------ ECS Service -------- **

resource "aws_ecs_service" "fastapi-service" {
  name                 = var.ecs_service_name
  cluster              = aws_ecs_cluster.fastapi-cluster.id
  task_definition      = aws_ecs_task_definition.task_definition.arn
  desired_count        = 1
  launch_type          = "EC2"
  force_new_deployment = true

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "${var.env}_FastAPI_image"
    container_port   = 5000
  }

}


