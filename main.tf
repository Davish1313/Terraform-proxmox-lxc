provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = var.pm_api_token_id
  insecure  = true
}

module "lxc" {
  source          = "./modules/lxc"
  lxc_names       = var.lxc_names
  proxmox_node    = var.proxmox_node
  proxmox_storage = var.proxmox_storage
  lxc_password    = var.lxc_password
  ssh_public_key  = var.ssh_public_key
  bridge          = var.bridge
  vcpu            = var.vcpu
  memory          = var.memory
  disk_size       = var.disk_size
  os_template     = var.os_template
  lxc_project     = var.lxc_project
}
