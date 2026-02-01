variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project, used for resource naming and tagging"
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, production)"
  type        = string
  default     = "production"
}

variable "db_user_name" {
  description = "RDS database username"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_user_name) > 5
    error_message = "DB username must be longer than 5 characters."
  }
}

variable "db_user_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_user_password) > 8
    error_message = "DB password must be longer than 8 characters."
  }
}
