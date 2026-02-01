locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# VPC with VPC Endpoints (no NAT Gateway - cost optimized)
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  common_tags  = local.common_tags
}

# Security Groups
module "security_groups" {
  source = "./modules/security_groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
  common_tags  = local.common_tags
}

# IAM Roles for ECS Task Execution
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

# RDS Database in Private Subnets
module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  vpc_cidr              = var.vpc_cidr
  database_subnet_ids   = module.vpc.private_subnet_ids
  ecs_security_group_id = module.security_groups.ecs_tasks_security_group_id
  db_name               = var.db_name
  db_user               = var.db_user
  db_password           = var.db_password
  common_tags           = local.common_tags
}

# ECS Cluster, Task Definitions, and Services
module "ecs" {
  source = "./modules/ecs"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_security_group_id = module.security_groups.ecs_tasks_security_group_id
  execution_role_arn    = module.iam.ecs_task_execution_role_arn

  aws_region                   = var.aws_region
  db_name                      = var.db_name
  db_user                      = var.db_user
  db_host                      = module.rds.rds_endpoint
  db_port                      = "5432"
  backend_ecr_repository       = var.backend_ecr_repository
  db_password_ssm_parameter    = var.db_password_ssm_parameter
  app_secret_key_ssm_parameter = var.app_secret_key_ssm_parameter
  common_tags                  = local.common_tags
}

# SSM Parameters for Secrets
resource "aws_ssm_parameter" "db_password" {
  name  = var.db_password_ssm_parameter
  type  = "SecureString"
  value = var.db_password

  tags = merge(local.common_tags, {
    Name = "Database Password"
  })
}

resource "aws_ssm_parameter" "app_secret_key" {
  name  = var.app_secret_key_ssm_parameter
  type  = "SecureString"
  value = var.app_secret_key

  tags = merge(local.common_tags, {
    Name = "Application Secret Key"
  })
}
