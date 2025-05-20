variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_sg_ids" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "health_check_path" {
  description = "Path for ALB health check"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
