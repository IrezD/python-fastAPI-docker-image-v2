variable "default_region" {
  description = "The is the primary region for all deployed resources"
}

variable "secondary_region" {
  description = "This is the second region for all deployed resources"
}

variable "env" {
  description = "Describe the environment"
}

variable "repo_name" {
  description = "Elastic Container Registry (ECR) repository name"
}

variable "image_tag" {
  description = "Image tag to be entered at runtime for production while staging can use the default value"
  default     = "latest"
}

variable "vpc_id" {
  description = "ID number for default VPC"
}

variable "subnets_for_ecs" {
  description = "list of subnets in Frankfurt region for ecs"
  sensitive   = true
  default     = ["subnet-0dac9ab248dbb9596", "subnet-0a933dc6606abaeb0", "subnet-0ed459ed9dbe8e041"]
}

variable "ipv4_cidr_for_ecs" {
  description = "CIDR block for Security group"
  sensitive   = true
  default     = ["172.31.32.0/20", "172.31.0.0/20", "172.31.16.0/20"]
}

variable "ecs_service_name" {
  description = "Corresponds to the name of the ECS service which will be different for both environments"
}

variable "fqdn" {
  description = "Fully qualified domain name"
}

variable "hosted_zone_id" {
  description = "Hosted zone ID for Route53"
}

variable "ami_id" {
  description = "Amazon Machine Image ID for Ec2 Instances"
  default     = "ami-0029cbd17e0d653cf"
  sensitive   = true
}

variable "instance_type" {
  description = "Instance type for EC2"
  default     = "t2.micro"
}

variable "capacity_provider_name" {
  description = "Name of EC2 capacity provider for ECS container"
}