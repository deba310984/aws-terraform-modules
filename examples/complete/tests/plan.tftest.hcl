# Native `terraform test` (Terraform >= 1.6). Run from examples/complete:
#   terraform test
# Uses a plan (creates nothing) but calls AWS APIs for provider setup,
# so AWS credentials must be configured.

run "network_shape" {
  command = plan

  assert {
    condition     = length(module.vpc.public_subnet_ids) == 2
    error_message = "Expected 2 public subnets."
  }

  assert {
    condition     = length(module.vpc.private_subnet_ids) == 2
    error_message = "Expected 2 private subnets."
  }
}

run "sg_wiring" {
  command = plan

  assert {
    condition     = module.app_sg.security_group_id != ""
    error_message = "App security group should be created."
  }
}
