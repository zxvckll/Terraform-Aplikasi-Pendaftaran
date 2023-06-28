provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "rawat-jalan-tf-state-backend-ci-cd"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.23.0"
    }
  }
  required_version = "~> 1.0"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "rawat-jalan-tf-state-backend-ci-cd"
}