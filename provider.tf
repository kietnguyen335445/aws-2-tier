terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
 backend "s3" {
    bucket         = "bucket-backend-k1"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    use_lockfile   = true
  }
}
provider "aws" {
  region= var.region
}
