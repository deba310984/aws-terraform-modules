# Implementation Notes

## Why modules
The goal is reuse. Instead of copy-pasting VPC and security-group blocks into
every environment, the infrastructure is packaged as modules with a clear
input/output interface. `environments/dev` and `environments/prod` call the
same `vpc` module with different inputs (2 AZs + single NAT vs 3 AZs + one NAT
per AZ), proving the same code produces different-sized, consistent stacks.

## Design decisions
- **Thin, composable modules.** `vpc` and `security-group` each do one job and
  expose only what callers need. A caller wires them together (e.g. the app SG
  trusts the ALB SG by `source_security_group_id`).
- **Rule-driven security group.** One module builds any tier's SG from an
  `ingress_rules` list, so there is no `alb-sg` / `app-sg` / `db-sg`
  duplication.
- **Optional NAT.** `enable_nat_gateway` and `single_nat_gateway` let the same
  module serve a cheap dev VPC and an HA prod VPC. Route-table wiring adapts
  via a computed `nat_count` local.
- **Provider requirements live in each module** (`versions.tf`) so modules can
  be validated standalone and published independently.
- **`merge(var.tags, {...})`** keeps caller tags while adding a `Name`.

## Module versioning (real-world)
When modules live in their own Git repo or a registry, pin them by version:
```hcl
module "vpc" {
  source  = "git::https://example.com/modules/vpc.git?ref=v1.2.0"
  # or a Terraform Registry reference with version = "~> 1.2"
}
```
Pinning prevents an upstream module change from silently altering an apply.

## Remote state
Each environment should use its own remote state (S3 + DynamoDB lock) so teams
don't clobber each other. The `backend "s3"` block is stubbed in the
environment configs; create the bucket + lock table once, then
`terraform init -migrate-state`.

## Verification
- `terraform fmt -check -recursive` passes.
- CI (`.github/workflows/terraform.yml`) runs `fmt -check` and
  `init -backend=false` + `validate` on every module and configuration.
- `examples/complete` includes a native `terraform test` (plan-time assertions).
