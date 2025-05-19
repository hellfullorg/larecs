name_prefix = "lara-stg"
vpc_cidr = "10.10.0.0/16"
public_subnet_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnet_cidrs = ["10.10.3.0/24", "10.10.4.0/24"]
availability_zones = ["eu-west-1a", "eu-west-1b"]

ecr_repo_name = "larecs-stg"
redis_name = "larecs-stg-redis"
alb_name = "larecs-stg-alb"
cluster_name = "larecs-stg-cluster"
app_name = "larecs-stg-app"

laravel_image = "larecs-stg-laravel:latest"
nginx_image = "larecs-stg-nginx:latest"
desired_count = 1

environment = [
  {
    name = "APP_ENV"
    value = "stg"
  },
  {
    name = "APP_DEBUG"
    value = "true"
  }
]

tags = {
  Environment = "stg"
  Project     = "larecs"
  ManagedBy   = "terraform"
}

cloudflare_api_token = "your-cloudflare-token"
cloudflare_account_id = "your-cloudflare-account-id"
domain_name = "example.com"
app_subdomain = "stg"
certificate_arn = "arn:aws:acm:eu-west-1:123456789012:certificate/your-certificate-id" 