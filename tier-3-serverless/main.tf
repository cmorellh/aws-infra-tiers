locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# VPC for RDS and Lambda connectivity
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  common_tags  = local.common_tags
}

# Aurora Serverless v2 (pay-per-use)
module "rds" {
  source = "./modules/rds"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  lambda_sg_id      = module.lambda.lambda_security_group_id
  vpc_cidr          = var.vpc_cidr
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
  common_tags       = local.common_tags
}

# Lambda Functions with VPC access
module "lambda" {
  source = "./modules/lambda"

  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_endpoint        = module.rds.cluster_endpoint
  db_name            = var.db_name
  db_user            = var.db_user
  db_password        = var.db_password
  lambda_filename    = var.lambda_filename
  common_tags        = local.common_tags
}

# API Gateway
module "api_gateway" {
  source = "./modules/api_gateway"

  project_name        = var.project_name
  environment         = var.environment
  lambda_function_arn = module.lambda.function_arn
  lambda_invoke_arn   = module.lambda.invoke_arn
  common_tags         = local.common_tags
}
