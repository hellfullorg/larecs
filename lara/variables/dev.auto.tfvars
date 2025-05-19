name_prefix = "lara-dev"
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["eu-west-1a", "eu-west-1b"]


ecr_repo_name = "lara-dev"
redis_name = "lara-dev-redis"
alb_name = "lara-dev-alb"
cluster_name = "lara-dev-cluster"
app_name = "lara-dev-app"

laravel_image = "lara-dev-laravel:latest"
nginx_image = "lara-dev-nginx:latest"
desired_count = 1

environment = [
  {
    name = "APP_ENV"
    value = "dev"
  },
  {
    name = "APP_DEBUG"
    value = "true"
  }
]

tags = {
  Environment = "dev"
  Project     = "lara"
  ManagedBy   = "terraform"
}

project = "lara"
env = "dev"

cloudflare_api_token = "your-cloudflare-token"
cloudflare_account_id = "your-cloudflare-account-id"
domain_name = "hellfull.com"
app_subdomain = "dev"
certificate_arn = "arn:aws:acm:eu-west-1:123456789012:certificate/your-certificate-id" 