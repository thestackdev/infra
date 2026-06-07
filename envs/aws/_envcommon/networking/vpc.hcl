terraform {
  source = "${dirname(dirname(find_in_parent_folders("root.hcl")))}//modules/aws/networking/vpc"
}
