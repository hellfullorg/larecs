provider "aws" {
  region = local.tfvars.aws_region

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = "larecs"
      ManagedBy   = "terraform"
    }
  }
}

provider "cloudflare" {
  api_token = local.tfvars.cloudflare_api_token
}