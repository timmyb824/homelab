resource "proxmox_vm_qemu" "nodes" {
  count             = 3
  name              = "k3s-${count.index}"
  vmid              = "31${count.index}"
  target_node       = "${var.pm_node}"
  agent             = 1

  clone             = "ubuntu-2004-cloudinit-template"

  os_type           = "cloud-init"
  cores             = 2
  sockets           = "1"
  cpu               = "host"
  memory            = 4096
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "32G"
    type            = "scsi"
    storage         = "local-zfs"
    iothread        = 1
  }

  network {
    model           = "virtio"
    bridge          = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0         = "ip=192.168.86.18${count.index}/24,gw=192.168.86.1"
  sshkeys = file("${var.ssh_key_file}")

}

resource "proxmox_vm_qemu" "worker_nodes" {
  count             = 3
  name              = "k3s-${count.index}-worker"
  vmid              = "32${count.index}"
  target_node       = "${var.pm_node}"
  agent             = 1

  clone             = "ubuntu-2004-cloudinit-template"

  os_type           = "cloud-init"
  cores             = 2
  sockets           = "1"
  cpu               = "host"
  memory            = 4096
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "32G"
    type            = "scsi"
    storage         = "local-zfs"
    iothread        = 1
  }

  network {
    model           = "virtio"
    bridge          = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0         = "ip=192.168.86.19${count.index}/24,gw=192.168.86.1"
  # ipconfig0         = "ip=192.168.86.192/24,gw=192.168.86.1"
  sshkeys = file("${var.ssh_key_file}")
}
