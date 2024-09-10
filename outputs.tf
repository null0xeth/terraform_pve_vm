output "server_name" {
  description = "Flattened version of output `name`"
  value       = flatten(proxmox_virtual_environment_vm.node[*].name)
}

output "server_ipv4" {
  description = "Flattened version of output `ipv4`"
  value       = flatten(proxmox_virtual_environment_vm.node[*].ipv4_addresses[1])

}

output "name" {
  description = "Map with all server names of the resources we have created"
  value       = toset(proxmox_virtual_environment_vm.node[*].name)
}

output "ipv4" {
  description = "Map with all server ipv4 addresses of the resources we have created"
  value       = flatten(proxmox_virtual_environment_vm.node[*].ipv4_addresses[1])
}

output "raw_map" {
  description = "Nested map containing `name => ipv4` pairs per VM type."
  value = {
    for category, child in proxmox_virtual_environment_vm.node : category => zipmap(flatten([child.name]), (flatten(child.ipv4_addresses[1])))



  }
  # value = {
  #   for category, child in proxmox_virtual_environment_vm.node :
  #   category => { "${child.name}" = child.ipv4_addresses[1] }
  # }
}
