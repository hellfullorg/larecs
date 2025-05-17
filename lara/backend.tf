terraform {
  backend "s3" {
    bucket         = "larecs-terraform-state"
    key            = "lara/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "larecs-terraform-locks"
  }
} 