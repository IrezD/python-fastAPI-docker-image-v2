
output "ecr_registry_id" {
  value = aws_ecrpublic_repository.fastapi-ecr-public.registry_id
}

output "ecr_repository_name" {
  value = aws_ecrpublic_repository.fastapi-ecr-public.repository_name
}