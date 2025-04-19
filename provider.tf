terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
# backend "s3" {
#     bucket         = "bucket-backend-k1"
#     key            = "terraform.tfstate"
#     region         = "ap-southeast-1"
#     dynamodb_table = "backend-locking"
#     encrypt        = true
#     }
 }
provider "aws" {
  region= var.region
}