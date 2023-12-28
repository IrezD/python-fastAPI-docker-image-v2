resource "aws_acm_certificate" "cert" {
  provider = aws.secondary_region

  domain_name       = var.fqdn
  validation_method = "EMAIL"

}