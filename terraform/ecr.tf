resource "aws_ecrpublic_repository" "fastapi-ecr-public" {
  provider = aws.secondary_region

  repository_name = var.repo_name

  catalog_data {
    about_text  = "A FastAPI docker image"
    description = "This is a containerized images of FastAPI stored on ECR ${var.env} environment"
  }
}