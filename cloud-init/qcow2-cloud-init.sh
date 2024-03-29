wget https://download.fedoraproject.org/pub/fedora/linux/releases/39/Cloud/x86_64/images/Fedora-Cloud-Base-39-1.5.x86_64.qcow2
qm create 5001 --name fedora-vm --memory 8192 --net0 virtio,bridge=vmbr0
qm importdisk 5001 Fedora-Cloud-Base-39-1.5.x86_64.qcow2 nvme -format qcow2
qm set 5001 --scsihw virtio-scsi-pci --scsi0 nvme:vm-5001-disk
qm set 5001 --ide2 nvme:cloudinit --boot c --bootdisk scsi0 --serial0 socket --vga serial0

