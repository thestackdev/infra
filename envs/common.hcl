locals {
  project    = "thestackdev"
  managed_by = "terragrunt"
  common_tags = {
    Project   = local.project
    ManagedBy = local.managed_by
  }
}
