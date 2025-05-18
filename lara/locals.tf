locals {
  # Extract environment from workspace name (lara-dev -> dev)
  environment = replace(terraform.workspace, "lara-", "")
  
  # Load the appropriate tfvars file based on environment
  tfvars = yamldecode(file("${path.module}/variables/${local.environment}.tfvars"))
  
  # Map the loaded variables to our variables
  name_prefix         = local.tfvars.name_prefix
  vpc_cidr           = local.tfvars.vpc_cidr
  public_subnet_cidrs = local.tfvars.public_subnet_cidrs
  private_subnet_cidrs = local.tfvars.private_subnet_cidrs
  availability_zones  = local.tfvars.availability_zones
  ecr_repo_name      = local.tfvars.ecr_repo_name
  redis_name         = local.tfvars.redis_name
  alb_name           = local.tfvars.alb_name
  cluster_name       = local.tfvars.cluster_name
  app_name           = local.tfvars.app_name
  laravel_image      = local.tfvars.laravel_image
  nginx_image        = local.tfvars.nginx_image
  desired_count      = local.tfvars.desired_count
  environment_vars   = local.tfvars.environment
  tags               = local.tfvars.tags
  cloudflare_api_token = local.tfvars.cloudflare_api_token
  cloudflare_account_id = local.tfvars.cloudflare_account_id
  domain_name        = local.tfvars.domain_name
  app_subdomain      = local.tfvars.app_subdomain
  certificate_arn    = local.tfvars.certificate_arn
}