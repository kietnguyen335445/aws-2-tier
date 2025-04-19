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
4. Destroy Infrastructure
```bash
terraform destroy --var-file "terraform.tfvars"
```
