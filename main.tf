provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = var.pm_api_token_id
  insecure  = var.pm_insecure

  ssh {
    agent    = true
    username = var.pm_ssh_username
    node {
      name    = var.proxmox_node
      address = var.pm_ssh_node_address
    }
  }
}

module "lxc" {
  source           = "./modules/lxc"
  lxc_names        = var.lxc_names
  proxmox_node     = var.proxmox_node
  proxmox_storage  = var.proxmox_storage
  lxc_password     = var.lxc_password
  ssh_public_key   = var.ssh_public_key
  bridge           = var.bridge
  vcpu             = var.vcpu
  memory           = var.memory
  disk_size        = var.disk_size
  os_template      = var.os_template
  lxc_project      = var.lxc_project
  ansible_packages = var.ansible_packages
  allow_root_login = var.allow_root_login
}
