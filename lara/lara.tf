module "vpc" {
  source = "../modules/vpc"

  name                 = var.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "security_groups" {
  source      = "../modules/security_groups"
  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
  tags        = var.tags
}

module "ecr" {
  source = "../modules/ecr"
  
  name = var.ecr_repo_name
  tags = var.tags
}

module "iam" {
  source = "../modules/iam"

  name_prefix = var.name_prefix
  tags        = var.tags
}

module "redis" {
  source = "../modules/redis"

  name               = var.redis_name
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.redis_sg_id]
  tags               = var.tags
}

module "alb" {
  source = "../modules/alb"

  alb_name           = var.alb_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  alb_sg_ids         = [module.security_groups.alb_sg_id]
  health_check_path  = "/"
  tags               = var.tags
}

module "ecs" {
  source             = "../modules/ecs"

  cluster_name       = var.cluster_name
  app_name           = var.app_name
  laravel_image      = var.laravel_image
  nginx_image        = var.nginx_image
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_sg_id]
  desired_count      = var.desired_count
  environment        = var.environment
}

