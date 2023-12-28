terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.default_region

  default_tags {
    tags = {
      Environment = "${title(var.env)} Environment"
    }
  }
}

provider "aws" {
  alias  = "ecr_region"
  region = var.secondary_region

  default_tags {
    tags = {
      Environment = "${title(var.env)} Environment"
    }
  }
}
