# About this Project
This project involves creating a Docker image for a FastAPI and deploying it on ECS. The infrastructure is built using Terraform, and continuous deployment is implemented through GitHub Actions. The different Docker images tags are stored on ECR public repository. The docker containers are running on ECS using EC2 lanuch type which are managed by Elastic Load Balancer on AWS.
