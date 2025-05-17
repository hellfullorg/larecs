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

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "redis_sg_id" {
  description = "Security group ID for Redis"
  type        = string
}

variable "alb_name" {
  description = "Name for the ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_sg_id" {
  description = "Security group ID for the ALB"
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

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
}
