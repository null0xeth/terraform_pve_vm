resource "proxmox_virtual_environment_vm" "node" {
  name  = format("%s0%d", var.cluster_spec.base_name, count.index + 1)
  vm_id = (var.cluster_spec.base_id + count.index)
  count = var.cluster_spec.component_size
  tags  = var.resource_tags

  node_name = var.provider_proxmox.node
  template  = local.cloning.create_template

  #--> Singular Parameters
  bios            = local.machine.bios
  boot_order      = local.machine.boot_order
  stop_on_destroy = local.general.stop_on_destroy
  machine         = local.machine.machine
  migrate         = local.general.migrate
  on_boot         = local.general.on_boot
  reboot          = local.general.reboot
  scsi_hardware   = local.hardware.scsi_type
  started         = local.general.started

  agent {
    enabled = local.general.agent
  }

  cpu {
    architecture = local.hardware.cpu_arch
    cores        = var.cluster_spec.config.cpu_cores
    type         = local.hardware.cpu_type
  }

  # Cloning
  dynamic "clone" {
    for_each = local.cloning.clone_template == false ? [] : list(local.cloning)

    content {
      datastore_id = "local-zfs"
      node_name    = var.provider_proxmox.node
      vm_id        = clone.clone_from_id
    }
  }

  # VM disks
  dynamic "disk" {
    for_each = var.cluster_spec.config.disks == null ? {} : var.cluster_spec.config.disks
    content {
      aio          = local.disks.aio
      iothread     = local.disks.iothread
      backup       = local.disks.backup
      cache        = local.disks.cache
      datastore_id = disk.value.datastore_id
      discard      = local.disks.discard
      file_format  = local.disks.file_format
      file_id      = disk.value.file_id
      interface    = disk.value.interface
      size         = disk.value.size
      ssd          = disk.value.ssd
    }
  }
  # EFI disks
  efi_disk {
    datastore_id      = local.efi_disk.datastore_id
    file_format       = local.efi_disk.file_format
    type              = local.efi_disk.type
    pre_enrolled_keys = local.efi_disk.pre_enrolled_keys
  }

  # Serial device
  serial_device {
    device = local.machine.serial_device
  }

  #--> Cloud Init
  initialization {
    #-> Cloud init configuration
    type                = local.initialization.type
    vendor_data_file_id = var.cloud_init_id
    datastore_id        = local.initialization.ci_datastore
    interface           = local.initialization.ci_interface

    user_account {
      password = var.auth_bundle.password
      username = var.auth_bundle.username
      keys     = var.auth_bundle.ssh_keys
    }

    #-> ipconfig0
    dynamic "ip_config" {
      for_each = local.networks == null ? [{}] : local.networks
      content {
        ipv4 {
          address = "dhcp"
        }
      }
    }
  }
  # VM Memory
  memory {
    dedicated = var.cluster_spec.config.memory
  }

  # Network interfaces
  dynamic "network_device" {
    for_each = local.networks == null ? [{}] : local.networks
    content {
      bridge  = network_device.value["bridge"]
      model   = network_device.value["model"]
      vlan_id = network_device.value["vlan_id"]
      mtu     = network_device.value["mtu"]
    }
  }

  # Guest OS config
  operating_system {
    type = local.machine.operating_system_type
  }

  # Display config
  vga {
    memory = local.vga.memory
    type   = local.vga.type
  }
}



