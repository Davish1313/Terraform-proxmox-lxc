provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = var.pm_api_token_id
  insecure  = true
}

resource "proxmox_virtual_environment_container" "lxc" {
  for_each    = toset(var.lxc_names)
  description = "LXC Container - ${each.value}"
  node_name   = var.proxmox_node
  unprivileged = true
  started     = true

  tags = ["terraform", var.lxc_project]

  initialization {
    hostname = each.value

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      password = var.lxc_password
      keys     = [var.ssh_public_key]
    }
  }

  operating_system {
    template_file_id = "local:vztmpl/${var.os_template}.tar.zst"
    type             = "debian"
  }

  protection = true

  cpu {
    cores = var.vcpu
  }

  memory {
    dedicated = var.memory
    swap       = var.swap
  }

  disk {
    datastore_id = var.proxmox_storage
    size         = tonumber(substr(var.disk_size, 0, length(var.disk_size) - 1))
  }

  network_interface {
    name   = "eth0"
    bridge = var.bridge
  }
}