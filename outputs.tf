output "lxc_info" {
  description = "Información de los LXC creados"
  value = {
    lxc1 = { id = proxmox_virtual_environment_container.lxc1.vm_id }
    lxc2 = { id = proxmox_virtual_environment_container.lxc2.vm_id }
  }
}

output "lxc_ids" {
  description = "IDs de los contenedores"
  value = {
    lxc1 = proxmox_virtual_environment_container.lxc1.vm_id
    lxc2 = proxmox_virtual_environment_container.lxc2.vm_id
  }
}