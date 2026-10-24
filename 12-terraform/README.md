# Terraform practice — safety-first

Use the Terraform+LocalStack playground first for AWS API-shaped practice, or Terraform+GCP only if the sandbox explicitly permits the required services. Always inspect `terraform version`, provider config, credentials and any workspace/state before running.

Required workflow:

```bash
terraform fmt -check -recursive
terraform init -backend=false    # only when the project/provider makes this valid
terraform validate
terraform plan -out=tfplan       # inspect plan before applying
terraform show tfplan
```

Do not run `apply` against an account you do not control. Never commit `*.tfstate`, plan files, `.terraform/`, service-account keys, tokens or secret tfvars. State can contain secrets. Understand refresh/plan, drift, dependencies, modules, state locking, import, destroy scope and provider upgrades. For this plan, a correct plan explanation is more valuable than creating billable resources quickly.
