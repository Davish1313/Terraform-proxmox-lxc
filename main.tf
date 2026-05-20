locals {
  disk_value = tonumber(substr(var.disk_size, 0, length(var.disk_size) - 1))
  disk_unit  = substr(var.disk_size, length(var.disk_size) - 1, 1)
  disk_gb    = local.disk_unit == "M" ? ceil(local.disk_value / 1024) : local.disk_value
}

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
  }

  disk {
    datastore_id = var.proxmox_storage
    size         = local.disk_gb
  }

  network_interface {
    name   = "eth0"
    bridge = var.bridge
  }
}