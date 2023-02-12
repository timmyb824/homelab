resource "proxmox_vm_qemu" "node" {
  name              = "${var.vm_name}"
  vmid              = "3${var.vm_id}"
  target_node       = "${var.pm_node}"
  # agent             = 1  # will error if agent is not already installed

  clone             = "ubuntu-2004-cloudinit-template"

  os_type           = "cloud-init"
  cores             = 2
  sockets           = "1"
  cpu               = "host"
  memory            = "${var.vm_memory}"
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "${var.vm_disk_size}"
    type            = "scsi"
    storage         = "${var.storage_name}"
    iothread        = 1
  }

  network {
    model           = "virtio"
    bridge          = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0         = "ip=${var.vm_ip}/24,gw=${var.vm_gw}"
  sshkeys = file("${var.ssh_key_file}")

}
