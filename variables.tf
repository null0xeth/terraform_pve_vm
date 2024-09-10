variable "auth_bundle" {}
variable "cloud_init_id" {}
variable "resource_tags" {}
variable "cluster_spec" {}

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
    endpoint          = optional(string)
    username          = optional(string)
    agent_socket      = optional(string)
    node              = optional(string)
    default_datastore = optional(string)
  })
  default = {}
}


