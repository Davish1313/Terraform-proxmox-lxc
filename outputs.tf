output "lxc_info" {
  description = "Información de los LXC creados"
  value       = module.lxc.lxc_info
}

output "lxc_ids" {
  description = "IDs de los contenedores"
  value       = module.lxc.lxc_ids
}
