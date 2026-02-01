variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet objects for DB subnet group"
  type        = list(any)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs for security group ingress"
  type        = list(string)
}

variable "db_az" {
  description = "Availability zone for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_user_name" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_user_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
