# 🚀 AWS 2-Tier Architecture using Terraform Modules

This project implements a modular, production-ready 2-Tier architecture on AWS using **Terraform**. It consists of a **Web Tier** (public) and a **Database Tier** (private). The infrastructure is built using Terraform modules for better reusability, scalability, and maintainability.

---

## 📌 Architecture Overview

- **Web Tier**:
  - Hosted on EC2 instances behind an Application Load Balancer (ALB)
  - Publicly accessible
  - Auto Scaling enabled (based on CPU usage)
- **Database Tier**:
  - AWS RDS (MySQL) hosted in private subnets
  - Only accessible from Web Tier via Security Groups
- **VPC**:
  - Multi-AZ architecture with public and private subnets
  - Internet Gateway for public access
  - NAT Gateway for private subnet internet access (e.g. RDS patching)
- **Remote Backend**:
  - State stored in **S3**
  - Handled locking
---

## 🧱 Project Structure

![Untitled2](https://github.com/user-attachments/assets/a6d2a3f6-08a8-4785-a690-08b1575fd225)


---
## Backend Configuration in Terraform:
```bash
resource "aws_s3_bucket" "backend_bucket" {
   bucket = "bucket-backend-k1"
 }
resource "aws_s3_bucket_versioning" "version" {
   bucket = aws_s3_bucket.backend_bucket.id
     versioning_configuration {
         status = "Enabled"
     }
 }
resource "aws_s3_bucket_server_side_encryption_configuration" "encryp" {
     bucket = aws_s3_bucket.backend_bucket.bucket
     rule {
         apply_server_side_encryption_by_default {
             sse_algorithm = "AES256"
         }
     }
 }
```
Add the Terraform backend block in the Terraform provider block in the provider.tf file.
```bash
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
```
![s3lock](https://github.com/user-attachments/assets/db03b403-0365-4bfa-bf30-be5a70ea5297)

## 🔧 Terraform Setup

### 1. Initialize Terraform

```bash
terraform init
```
2. Preview Changes
```bash
terraform plan --var-file "terraform.tfvars"
```
3. Apply Configuration
```bash
terraform apply --var-file "terraform.tfvars"
```
When the components created successfully. Go to the Load Balancer page, copy the DNS name for the Terraform-2Tier-alb

![load2](https://github.com/user-attachments/assets/7dd3ffb7-8f3a-43ee-84f0-d88a0bd4a990)



4. Destroy Infrastructure
```bash
terraform destroy --var-file "terraform.tfvars"
```
