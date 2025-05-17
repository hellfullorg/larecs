variable "aws_region" {
  default     = "eu-north-1"
  description = "AWS region to deploy resources in"
}

variable "bucket_name" {
  default     = "terraform-state-helias"
  description = "Name of the S3 bucket for storing Terraform state"
}

variable "dynamodb_table_name" {
  default     = "terraform-locks"
  description = "Name of the DynamoDB table for state locking"
}
