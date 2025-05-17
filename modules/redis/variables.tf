variable "name" {
  description = "Name of the ElastiCache Redis cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets in which to deploy Redis"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups to associate with Redis"
  type        = list(string)
}

variable "node_type" {
  description = "Instance type for Redis nodes"
  type        = string
  default     = "cache.t3.micro"
}

variable "num_cache_nodes" {
  description = "Number of Redis cache nodes"
  type        = number
  default     = 1
}

variable "port" {
  description = "Redis port"
  type        = number
  default     = 6379
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
