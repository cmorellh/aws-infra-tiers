module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  common_tags          = local.common_tags
}

module "rds" {
  source = "./modules/rds"

  project_name         = var.project_name
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_subnets
  private_subnet_cidrs = local.private_subnet_cidrs
  db_az                = local.availability_zones[0]
  db_name              = "${var.project_name}_db"
  db_user_name         = var.db_user_name
  db_user_password     = var.db_user_password
  common_tags          = local.common_tags
}

module "webserver" {
  source = "./modules/webserver"

  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  common_tags    = local.common_tags
}
