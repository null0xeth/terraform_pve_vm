<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.64.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >=0.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_vm.node](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_bundle"></a> [auth\_bundle](#input\_auth\_bundle) | TBA | <pre>object({<br>    username = optional(string)<br>    password = optional(string)<br>    ssh_keys = optional(list(string))<br>  })</pre> | `{}` | no |
| <a name="input_cloud_init_id"></a> [cloud\_init\_id](#input\_cloud\_init\_id) | Path to a cloud-init yaml file | `string` | `""` | no |
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | Contains the cluster topology and configuration variables passed to the cluster module. | <pre>map(object({<br>    base_id        = optional(number, 300)<br>    base_name      = optional(string, "machine")<br>    component_id   = optional(string)<br>    component_size = optional(number, 3)<br>    node           = optional(string, "pve")<br><br>    config = object({<br>      cpu_cores = optional(number, 4)<br>      memory    = optional(number, 4096)<br><br>      disks = optional(map(object({<br>        datastore_id = optional(string)<br>        file_id      = optional(string)<br>        interface    = optional(string)<br>        size         = optional(number)<br>        ssd          = optional(bool)<br>      })))<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_common_vm_config"></a> [common\_vm\_config](#input\_common\_vm\_config) | Configuration shared by all resources | <pre>object({<br>    enable_agent          = optional(bool, true)<br>    bios                  = optional(string, "ovmf")<br>    boot_order            = optional(list(string), ["scsi1"])<br>    ci_datastore_id       = optional(string, "local-zfs")<br>    ci_interface          = optional(string, "scsi0")<br>    ci_type               = optional(string, "nocloud")<br>    clone_template        = optional(bool, false)<br>    common_networks       = optional(list(any))<br>    cpu_arch              = optional(string, "x86_64")<br>    cpu_flags             = optional(list(string), ["+hv-evmcs", "+aes"])<br>    cpu_type              = optional(string, "host")<br>    disk_aio              = optional(string, "native")<br>    disk_backup           = optional(bool, false)<br>    disk_cache            = optional(string, "directsync")<br>    disk_discard          = optional(string, "on")<br>    disk_file_format      = optional(string, "raw")<br>    disk_iothread         = optional(bool, true)<br>    disk_replicate        = optional(bool, false)<br>    efi_datastore_id      = optional(string, "local-zfs")<br>    efi_file_format       = optional(string, "raw")<br>    efi_type              = optional(string, "4m")<br>    efi_pre_enrolled_keys = optional(bool, false)<br>    machine_type          = optional(string, "q35")<br>    machine_serial_device = optional(string, "serial")<br>    migrate               = optional(bool, true)<br>    on_boot               = optional(bool, true)<br>    os_type               = optional(string, "l26")<br>    reboot                = optional(bool, false)<br>    scsi_hardware         = optional(string, "virtio-scsi-single")<br>    started               = optional(bool, true)<br>    startup               = optional(bool, false)<br>    stop_on_destroy       = optional(bool, true)<br>    template              = optional(bool, false)<br>    vga_memory            = optional(number, 16)<br>    vga_type              = optional(string, "serial0")<br>  })</pre> | `{}` | no |
| <a name="input_provider_aws"></a> [provider\_aws](#input\_provider\_aws) | hashicorp/aws provider configuration variables | <pre>object({<br>    region = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_provider_proxmox"></a> [provider\_proxmox](#input\_provider\_proxmox) | bpg/proxmox provider configuration variables | <pre>object({<br>    pve_agent_socket      = optional(string)<br>    pve_default_datastore = optional(string)<br>    pve_endpoint          = optional(string)<br>    pve_node              = optional(string)<br>    pve_username          = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | List of resource tags to be added to all created resources | `map(string)` | <pre>{<br>  "managed_by": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4"></a> [ipv4](#output\_ipv4) | Map with all server ipv4 addresses of the resources we have created |
| <a name="output_name"></a> [name](#output\_name) | Map with all server names of the resources we have created |
| <a name="output_raw_map"></a> [raw\_map](#output\_raw\_map) | Nested map containing `name => ipv4` pairs per VM type. |
| <a name="output_server_ipv4"></a> [server\_ipv4](#output\_server\_ipv4) | Flattened version of output `ipv4` |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | Flattened version of output `name` |
<!-- END_TF_DOCS -->