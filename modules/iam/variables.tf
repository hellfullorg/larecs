variable "name_prefix" {
  description = "Prefix for IAM role names"
  type        = string
}

variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}
