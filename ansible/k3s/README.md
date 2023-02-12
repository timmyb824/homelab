# Automated build of HA k3s Cluster with `kube-vip` and MetalLB

### Create Cluster

Once necessary updates have been made to your `inventory/hosts.ini` and `inventory/group_vars/all.yml` configuration then start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/my-cluster/hosts.ini
```

After deployment control plane will be accessible via virtual ip-address which is defined in `inventory/group_vars/all.yml` as `apiserver_endpoint`

### Remove k3s cluster

```bash
ansible-playbook reset.yml -i inventory/my-cluster/hosts.ini
```

>You should also reboot these nodes due to the VIP not being destroyed

## Thanks

Full credit for this goes to [techno-tim](https://github.com/techno-tim?type=source). For additional details including credit to others who contributed to this please see his repo [k3s-ansible](https://github.com/techno-tim/k3s-ansible).