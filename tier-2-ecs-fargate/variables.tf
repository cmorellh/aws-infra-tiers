variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Database configuration
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# ECR repository
variable "backend_ecr_repository" {
  description = "ECR repository URI for the backend container image"
  type        = string
}

# SSM Parameter names for secrets
variable "db_password_ssm_parameter" {
  description = "SSM Parameter name for database password"
  type        = string
  default     = "/myapp/db-password"
}

variable "app_secret_key_ssm_parameter" {
  description = "SSM Parameter name for application secret key"
  type        = string
  default     = "/myapp/secret-key"
}

variable "app_secret_key" {
  description = "Application secret key"
  type        = string
  sensitive   = true
}
