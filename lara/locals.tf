locals {
  # Extract environment from workspace name (lara-dev -> dev)
  environment = replace(terraform.workspace, "lara-", "")
  
  # Common tags for all resources
  common_tags = {
    Environment = local.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }

  # Construct the path to the tfvars file based on workspace
  tfvars_path = "${path.module}/variables/${local.environment}.auto.tfvars"
}