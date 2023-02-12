# Install nfs-subdir-external-provisioner for nfs storage on k3s

## Add the repo

```powershell
helm --kubeconfig .\config repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner

helm --kubeconfig .\config repo update
```

## Install from the repo

```powershell
helm --kubeconfig .\config install nfs-synologynas nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --set nfs.server=$SERVER --set nfs.path=/volume1/kubernetes --set storageClass.name=nfs-csi-synologynas --set storageClass.defaultClass=true
```

## Create storageClass

```powershell
kubectl --kubeconfig .\config create -f storageClass.yaml
```
