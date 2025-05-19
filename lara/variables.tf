variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming IAM resources"
  type        = string
}

variable "redis_name" {
  description = "Name for the Redis cluster"
  type        = string
}

variable "alb_name" {
  description = "Name for the ALB"
  type        = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "app_name" {
  description = "Name of the ECS application"
  type        = string
}

variable "laravel_image" {
  description = "Docker image URI for the Laravel container"
  type        = string
}

variable "nginx_image" {
  description = "Docker image URI for the Nginx sidecar"
  type        = string
}

variable "ecs_sg_id" {
  description = "Security group ID for the ECS service"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "environment" {
  description = "Environment variables for the Laravel container"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "app_subdomain" {
  description = "Subdomain for the application"
  type        = string
  default     = "app"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for the ALB"
  type        = string
}

