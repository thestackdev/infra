locals {
  project    = "thestackdev"
  managed_by = "terragrunt"
  common_tags = {
    Proejct   = local.project
    ManagedBy = local.managed_by
  }
}
