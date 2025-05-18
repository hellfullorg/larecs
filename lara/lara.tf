module "vpc" {
  source = "../modules/vpc"

  name                 = local.name_prefix
  vpc_cidr             = local.vpc_cidr
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  availability_zones   = local.availability_zones
  tags                 = local.tags
}

module "security_groups" {
  source      = "../modules/security_groups"
  name_prefix = local.name_prefix
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}

module "ecr" {
  source = "../modules/ecr"
  
  name = local.ecr_repo_name
  tags = local.tags
}

module "iam" {
  source = "../modules/iam"

  name_prefix = local.name_prefix
  tags        = local.tags
}

module "redis" {
  source = "../modules/redis"

  name               = local.redis_name
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.redis_sg_id]
  tags               = local.tags
}

module "alb" {
  source = "../modules/alb"

  alb_name           = local.alb_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  alb_sg_ids         = [module.security_groups.alb_sg_id]
  health_check_path  = "/"
  certificate_arn    = local.certificate_arn
  tags               = local.tags
}

module "ecs" {
  source             = "../modules/ecs"

  cluster_name       = local.cluster_name
  app_name           = local.app_name
  laravel_image      = local.laravel_image
  nginx_image        = local.nginx_image
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_sg_id]
  desired_count      = local.desired_count
  environment        = local.environment_vars
  target_group_arn   = module.alb.target_group_arn
  tags               = local.tags
}

