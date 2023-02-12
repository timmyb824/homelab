# Create cloud-init template

To create new cloud-init VM template in Proxmox:

- use either `inventory` or `inventory.yaml` and update it with your proxmox host
- modify `vars` section in [ansible/create-vm-template.yaml](ansible/create-vm-template.yaml) as needed to fit your needs
- from [ansible/proxmox](ansible/proxmox) directory run the

```shell
# the -K argument allows you to pass the sudo password
ansible-playbook -i ansible/inventory.yaml ansible/create-vm-template.yaml -K
```

Refer to the `terraform/` folder for help provisioning VM's with the newly created template.
