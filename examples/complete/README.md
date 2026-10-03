# Complete Example

Consumes the `vpc` and `security-group` modules to build a two-tier network:
Internet → ALB SG → App SG, with public and private subnets across 2 AZs and a
single NAT Gateway.

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply     # creates PAID resources (NAT Gateway)
terraform test      # runs tests/ (plan-time assertions)
terraform destroy   # tear down
```

> `plan`/`apply` need AWS credentials. `terraform fmt`/`validate` run offline
> after `init` downloads the provider.
