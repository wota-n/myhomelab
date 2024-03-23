#!/bin/bash

wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2
qm create 150 --memory 2048 --name debian-cloud --net0 virtio,bridge=vmbr0
qm importdisk 150 debian-12-genericcloud-amd64.qcow2 local-lvm
qm set 150 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-150-disk-0
qm set 150 --ide2 local-lvm:cloudinit
qm set 150 --boot c --bootdisk scsi0
qm set 150 --serial0 socket --vga serial0