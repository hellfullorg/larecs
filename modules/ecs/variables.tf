variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "app_name" {
  type        = string
  description = "App and ECS service name"
}

variable "laravel_image" {
  type        = string
  description = "ECR image URI for Laravel (PHP-FPM)"
}

variable "nginx_image" {
  type        = string
  description = "ECR image URI for Nginx reverse proxy"
}

variable "execution_role_arn" {
  type        = string
  description = "IAM execution role ARN for ECS task"
}

variable "task_role_arn" {
  type        = string
  description = "IAM task role ARN"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the ECS service"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "desired_count" {
  type        = number
  description = "Number of ECS task instances to run"
  default     = 1
}

variable "environment" {
  type        = list(object({
    name  = string
    value = string
  }))
  description = "Environment variables for the Laravel container"
  default     = []
}
