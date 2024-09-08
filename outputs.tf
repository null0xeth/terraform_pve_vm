output "name" {
  value = proxmox_virtual_environment_vm.node[*].name
}

output "ipv4" {
  value = flatten(proxmox_virtual_environment_vm.node[*].ipv4_addresses[1])
}
