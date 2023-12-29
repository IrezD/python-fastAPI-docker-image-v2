# ------ ECS Cluster ------- * 

resource "aws_ecs_cluster" "fastapi-cluster" {
  name = "fastapi-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# ------ Task definition ------- * 

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.env}-fastapi-container"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${var.env}_FastAPI_image",
    "image": "${aws_ecrpublic_repository.fastapi-ecr-public.repository_uri}:${var.image_tag}",
    "cpu": 500,
    "memory": 1024,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ]
  }
]
TASK_DEFINITION

}

# ------ ECS Service -------- * 

resource "aws_ecs_service" "fastapi-service" {
  name                 = var.ecs_service_name
  cluster              = aws_ecs_cluster.fastapi-cluster.id
  task_definition      = aws_ecs_task_definition.task_definition.arn
  desired_count        = 1
  launch_type          = "FARGATE"
  force_new_deployment = true

  network_configuration {
    subnets          = var.subnets_for_ecs
    security_groups  = [aws_security_group.ALB_to_containers.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "${var.env}_FastAPI_image"
    container_port   = 5000
  }



}


