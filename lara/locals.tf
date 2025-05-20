locals {
  # Load tfvars file and decode it
  tfvars = yamldecode(file("${path.module}/variables/${terraform.workspace}.tfvars"))
}