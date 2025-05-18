provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = "larecs"
      ManagedBy   = "terraform"
    }
  }
}