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
| <a name="input_auth_bundle"></a> [auth\_bundle](#input\_auth\_bundle) | n/a | `any` | n/a | yes |
| <a name="input_cloud_init_id"></a> [cloud\_init\_id](#input\_cloud\_init\_id) | n/a | `any` | n/a | yes |
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | n/a | `any` | n/a | yes |
| <a name="input_provider_aws"></a> [provider\_aws](#input\_provider\_aws) | hashicorp/aws provider configuration variables | <pre>object({<br>    region = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_provider_proxmox"></a> [provider\_proxmox](#input\_provider\_proxmox) | bpg/proxmox provider configuration variables | <pre>object({<br>    endpoint          = optional(string)<br>    username          = optional(string)<br>    agent_socket      = optional(string)<br>    node              = optional(string)<br>    default_datastore = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4"></a> [ipv4](#output\_ipv4) | Map with all server ipv4 addresses of the resources we have created |
| <a name="output_name"></a> [name](#output\_name) | Map with all server names of the resources we have created |
| <a name="output_raw_map"></a> [raw\_map](#output\_raw\_map) | Nested map containing `name => ipv4` pairs per VM type. |
| <a name="output_server_ipv4"></a> [server\_ipv4](#output\_server\_ipv4) | n/a |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | n/a |
<!-- END_TF_DOCS -->