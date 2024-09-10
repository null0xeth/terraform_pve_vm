resource "proxmox_virtual_environment_vm" "node" {
  bios            = var.common_vm_config.bios
  boot_order      = var.common_vm_config.boot_order
  count           = var.cluster_spec.component_size
  machine         = var.common_vm_config.machine_type
  migrate         = var.common_vm_config.migrate
  name            = format("%s0%d", var.cluster_spec.base_name, count.index + 1)
  node_name       = var.cluster_spec.node
  on_boot         = var.common_vm_config.on_boot
  reboot          = var.common_vm_config.reboot
  scsi_hardware   = var.common_vm_config.scsi_type
  started         = var.common_vm_config.started
  stop_on_destroy = var.common_vm_config.stop_on_destroy
  tags            = var.resource_tags
  template        = var.common_vm_config.create_template
  vm_id           = (var.cluster_spec.base_id + count.index)

  agent {
    enabled = var.common_vm_config.enable_agent
  }

  dynamic "clone" {
    for_each = var.common_vm_config.clone_template == false ? [] : list(local.cloning)

    content {
      datastore_id = "local-zfs"
      node_name    = var.provider_proxmox.pve_node
      vm_id        = clone.clone_from_id
    }
  }

  cpu {
    architecture = var.common_vm_config.cpu_arch
    cores        = var.cluster_spec.config.cpu_cores
    type         = var.common_vm_config.cpu_type
    units        = (var.cluster_spec.config.cpu_cores * 1024)
    flags        = var.common_vm_config.cpu_flags
  }

  dynamic "disk" {
    for_each = var.cluster_spec.config.disks == null ? {} : var.cluster_spec.config.disks
    content {
      aio          = var.common_vm_config.disk_aio
      backup       = var.common_vm_config.disk_backup
      cache        = var.common_vm_config.disk_cache
      datastore_id = disk.value.datastore_id
      discard      = var.common_vm_config.disk_discard
      file_format  = var.common_vm_config.disk_file_format
      file_id      = disk.value.file_id
      iothread     = var.common_vm_config.disk_iothread
      interface    = disk.value.interface
      size         = disk.value.size
      ssd          = disk.value.ssd
    }
  }

  efi_disk {
    datastore_id      = var.common_vm_config.efi_datastore_id
    file_format       = var.common_vm_config.efi_file_format
    type              = var.common_vm_config.efi_type
    pre_enrolled_keys = var.common_vm_config.efi_pre_enrolled_keys
  }

  initialization {
    datastore_id        = var.common_vm_config.ci_datastore_id
    interface           = var.common_vm_config.ci_interface
    type                = var.common_vm_config.type
    vendor_data_file_id = var.cloud_init_id

    dynamic "ip_config" {
      for_each = var.common_vm_config.common_networks == null ? [{}] : var.common_vm_config.common_networks
      content {
        ipv4 {
          address = "dhcp"
        }
      }
    }

    user_account {
      keys     = var.auth_bundle.ssh_keys
      password = var.auth_bundle.password
      username = var.auth_bundle.username
    }
  }

  memory {
    dedicated = var.cluster_spec.config.memory
  }

  dynamic "network_device" {
    for_each = var.common_vm_config.common_networks == null ? [{}] : var.common_vm_config.common_networks
    content {
      bridge  = network_device.value["bridge"]
      model   = network_device.value["model"]
      mtu     = network_device.value["mtu"]
      vlan_id = network_device.value["vlan_id"]
    }
  }

  operating_system {
    type = var.common_vm_config.os_type
  }

  serial_device {
    device = var.common_vm_config.machine_serial_device
  }

  vga {
    memory = var.common_vm_config.vga_memory
    type   = var.common_vm_config.vga_type
  }
}



