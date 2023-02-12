# Provisioning VMs

To provision Proxmox VMs:

- ensure you have a template VM to clone from; see `ansible/proxmox/` directory for help creating a new VM template
- create [terraform.tfvars](terraform.tfvars) file with needed values declared in the `variables.tf` file
- modify [main.tf](main.tf) to tweak the configuration of VMs
- from [proxmox](proxmox) directory, initialize directory, generate plan file, ensure plan values match expectations, then apply the plan to create the vm's:

```shell
terraform init
terraform plan -out plan
terraform apply "plan"
```
