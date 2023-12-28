resource "aws_acm_certificate" "cert" {

  domain_name       = var.fqdn
  validation_method = "EMAIL"

}