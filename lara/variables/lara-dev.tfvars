environment: "dev"
aws_region: "eu-west-1"
app_name: "lara"
app_port: 8000
app_count: 1
app_cpu: 256
app_memory: 512
domain_name: "larecs.com"
app_subdomain: "app"
cloudflare_account_id: ""
cloudflare_api_token: ""
redis_name: "lara-redis"
alb_name: "lara-alb"
ecr_repo_name: "lara"
laravel_image: "lara:latest"
nginx_image: "nginx:latest"
cluster_name: "lara-cluster"
name_prefix: "lara"
project: "larecs"
env: "dev"
certificate_arn: ""

tags:
  Environment: "dev"
  Project: "larecs"
  ManagedBy: "terraform"

vpc_cidr: "10.0.0.0/16"
public_subnet_cidrs: 
  - "10.0.1.0/24"
  - "10.0.2.0/24"
private_subnet_cidrs:
  - "10.0.3.0/24"
  - "10.0.4.0/24"
availability_zones:
  - "eu-west-1a"
  - "eu-west-1b"

desired_count: 1

environment:
  - name: "APP_ENV"
    value: "dev"
  - name: "APP_DEBUG"
    value: "true" 