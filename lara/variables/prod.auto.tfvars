name_prefix = "lara-prod"
vpc_cidr = "10.20.0.0/16"
public_subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnet_cidrs = ["10.20.3.0/24", "10.20.4.0/24"]
availability_zones = ["eu-west-1a", "eu-west-1b"]

ecr_repo_name = "larecs-prod"
redis_name = "larecs-prod-redis"
alb_name = "larecs-prod-alb"
cluster_name = "larecs-prod-cluster"
app_name = "larecs-prod-app"

laravel_image = "larecs-prod-laravel:latest"
nginx_image = "larecs-prod-nginx:latest"
desired_count = 2  # Higher count for production

environment = [
  {
    name = "APP_ENV"
    value = "prod"
  },
  {
    name = "APP_DEBUG"
    value = "false"  # Debug disabled in production
  }
]

tags = {
  Environment = "prod"
  Project     = "larecs"
  ManagedBy   = "terraform"
}

cloudflare_api_token = "your-cloudflare-token"
cloudflare_account_id = "your-cloudflare-account-id"
domain_name = "example.com"
app_subdomain = "app"  # No subdomain for production
certificate_arn = "arn:aws:acm:eu-west-1:123456789012:certificate/your-certificate-id" 