from pyinfra.operations import files, server

cloud_image_url="https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
cloud_image_path="/tmp/ubuntu-2004-server-amd64.qcow2"
template_id="4300"
template_name="ubuntu-2004-cloudinit-template"
template_memory="4096"
template_cores="2"
storage_type="local-zfs3"

files.download(
    name="Download cloud image",
    src=cloud_image_url,
    dest=cloud_image_path,
    mode=700
)

server.shell(
    name="create a VM to use as a template",
    commands=[f"qm create {template_id} --name {template_name} --memory {template_memory} --cores {template_cores} --net0 virtio,bridge=vmbr0"],
)

server.shell(
    name="import disk image",
    commands=[f"qm importdisk {template_id} {cloud_image_path} {storage_type}"],
)

server.shell(
    name="configure VM to use imported image",
    commands=[f"qm set {template_id} --scsihw virtio-scsi-pci --scsi0 {storage_type}:vm-{template_id}-disk-0"],
)

server.shell(
    name="add cloud-init image as CDROM",
    commands=[f"qm set {template_id} --ide2 {storage_type}:cloudinit"],
)

server.shell(
    name="configure boot from the image",
    commands=[f"qm set {template_id} --boot c --bootdisk scsi0"],
)

server.shell(
    name="attach serial console",
    commands=[f"qm set {template_id} --serial0 socket --vga serial0"],
)

server.shell(
    name="create template",
    commands=[f"qm template {template_id}"],
)