output "lxc_info" {
  description = "Información de los LXC creados"
  value       = { for name in var.lxc_names : name => { id = proxmox_virtual_environment_container.lxc[name].vm_id } }
}

output "lxc_ids" {
  description = "IDs de los contenedores"
  value       = { for name in var.lxc_names : name => proxmox_virtual_environment_container.lxc[name].vm_id }
}