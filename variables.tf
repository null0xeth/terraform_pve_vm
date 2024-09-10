variable "auth_bundle" {
  description = "TBA"
  default     = {}
  sensitive   = true
  type = object({
    username = optional(string)
    password = optional(string)
    ssh_keys = optional(list(string))
  })
}

variable "cloud_init_id" {
  description = "Path to a cloud-init yaml file"
  type        = string
  default     = ""
}

variable "resource_tags" {
  description = "List of resource tags to be added to all created resources"
  type        = map(string)
  default = {
    managed_by = "terraform"
  }
}

variable "cluster_spec" {
  description = "Contains the cluster topology and configuration variables passed to the cluster module."
  type = map(object({
    base_id        = optional(number, 300)
    base_name      = optional(string, "machine")
    component_id   = optional(string)
    component_size = optional(number, 3)
    node           = optional(string, "pve")

    config = object({
      cpu_cores = optional(number, 4)
      memory    = optional(number, 4096)

      disks = optional(map(object({
        datastore_id = optional(string)
        file_id      = optional(string)
        interface    = optional(string)
        size         = optional(number)
        ssd          = optional(bool)
      })))
    })
  }))
}

variable "provider_aws" {
  description = "hashicorp/aws provider configuration variables"
  type = object({
    region = optional(string)
  })
  default = {}
}

variable "provider_proxmox" {
  description = "bpg/proxmox provider configuration variables"
  type = object({
    pve_agent_socket      = optional(string)
    pve_default_datastore = optional(string)
    pve_endpoint          = optional(string)
    pve_node              = optional(string)
    pve_username          = optional(string)
  })
  default = {}
}

variable "common_vm_config" {
  description = "Configuration shared by all resources"
  default     = {}
  type = object({
    enable_agent          = optional(bool, true)
    bios                  = optional(string, "ovmf")
    boot_order            = optional(list(string), ["scsi1"])
    ci_datastore_id       = optional(string, "local-zfs")
    ci_interface          = optional(string, "scsi0")
    ci_type               = optional(string, "nocloud")
    clone_template        = optional(bool, false)
    common_networks       = optional(list(any))
    cpu_arch              = optional(string, "x86_64")
    cpu_flags             = optional(list(string), ["+hv-evmcs", "+aes"])
    cpu_type              = optional(string, "host")
    disk_aio              = optional(string, "native")
    disk_backup           = optional(bool, false)
    disk_cache            = optional(string, "directsync")
    disk_discard          = optional(string, "on")
    disk_file_format      = optional(string, "raw")
    disk_iothread         = optional(bool, true)
    disk_replicate        = optional(bool, false)
    efi_datastore_id      = optional(string, "local-zfs")
    efi_file_format       = optional(string, "raw")
    efi_type              = optional(string, "4m")
    efi_pre_enrolled_keys = optional(bool, false)
    machine_type          = optional(string, "q35")
    machine_serial_device = optional(string, "serial")
    migrate               = optional(bool, true)
    on_boot               = optional(bool, true)
    os_type               = optional(string, "l26")
    reboot                = optional(bool, false)
    scsi_hardware         = optional(string, "virtio-scsi-single")
    started               = optional(bool, true)
    startup               = optional(bool, false)
    stop_on_destroy       = optional(bool, true)
    template              = optional(bool, false)
    vga_memory            = optional(number, 16)
    vga_type              = optional(string, "serial0")
  })
}


