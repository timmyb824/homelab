# use aws provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

#configure the aws provider
provider "aws" {
  profile = var.awscli_profile
  region  = var.region
}