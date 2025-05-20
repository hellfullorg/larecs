module "vpc" {
  source = "../modules/vpc"

  name = local.tfvars.name_prefix
  vpc_cidr = local.tfvars.vpc_cidr
  public_subnet_cidrs = local.tfvars.public_subnet_cidrs
  private_subnet_cidrs = local.tfvars.private_subnet_cidrs
  availability_zones = local.tfvars.availability_zones
  tags = local.tfvars.tags
}

module "security_groups" {
  source = "../modules/security_groups"
  
  name_prefix = local.tfvars.name_prefix
  vpc_id = module.vpc.vpc_id
  tags = local.tfvars.tags
}

module "ecr" {
  source = "../modules/ecr"

  name = local.tfvars.ecr_repo_name
  tags = local.tfvars.tags
}

module "ecs" {
  source = "../modules/ecs"

  cluster_name = local.tfvars.cluster_name
  app_name = local.tfvars.app_name
  laravel_image = local.tfvars.laravel_image
  nginx_image = local.tfvars.nginx_image
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn = module.iam.task_role_arn
  subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_sg_id]
  desired_count = local.tfvars.desired_count
  environment = local.tfvars.environment
  target_group_arn = module.alb.target_group_arn
  tags = local.tfvars.tags
}

module "alb" {
  source = "../modules/alb"

  alb_name = local.tfvars.alb_name
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn = local.tfvars.certificate_arn
  alb_sg_ids = [module.security_groups.alb_sg_id]
  health_check_path = "/"
  tags = local.tfvars.tags
}

module "redis" {
  source = "../modules/redis"

  name = local.tfvars.redis_name
  subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.redis_sg_id]
  tags = local.tfvars.tags
}

module "iam" {
  source = "../modules/iam"

  name_prefix = local.tfvars.name_prefix
  tags = local.tfvars.tags
} 