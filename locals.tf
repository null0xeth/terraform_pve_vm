locals {
  cloning = {
    clone_template  = false
    clone_from_id   = null
    create_template = false
  }

  disks = {
    aio         = "native"
    iothread    = true
    backup      = false
    cache       = "directsync"
    discard     = "on"
    file_format = "raw"
  }

  general = {
    agent           = true
    on_boot         = true
    migrate         = true
    protection      = false
    stop_on_destroy = true
    reboot          = false
    started         = true
    startup         = false
    tablet_device   = true
  }

  machine = {
    bios                  = "ovmf"
    boot_order            = ["scsi1"]
    machine               = "q35"
    operating_system_type = "l26"
    serial_device         = "socket"
  }

  networks = [
    {
      # Management VLAN
      bridge  = "vmbr2"
      model   = "virtio"
      mtu     = 9000
      vlan_id = 130
    },
    {
      # Cluster VLAN
      bridge  = "vmbr3"
      model   = "virtio"
      vlan_id = 160
      mtu     = 9000
    },
  ]

  hardware = {
    cpu_arch  = "x86_64"
    cpu_type  = "host"
    scsi_type = "virtio-scsi-single"
  }

  efi_disk = {
    datastore_id      = "local-zfs"
    file_format       = "raw"
    type              = "4m"
    pre_enrolled_keys = false
  }

  initialization = {
    type                 = "nocloud"
    ci_datastore         = "local-zfs"
    ci_interface         = "scsi0"
    network_data_file_id = null
    user_data_file_id    = null
    meta_data_file       = null
  }

  vga = {
    memory = 16
    type   = "serial0"
  }
}
