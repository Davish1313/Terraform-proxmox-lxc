provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = var.pm_api_token_id
  insecure  = true
}

resource "proxmox_virtual_environment_container" "lxc1" {
  description  = "LXC Container - ${var.lxc_names[0]}"
  node_name    = var.proxmox_node
  unprivileged = true
  started      = false

  initialization {
    hostname = var.lxc_names[0]

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
    template_file_id = "local:vztmpl/debian-12-standard_12.12_1_amd64.tar.zst"
    type             = "debian"
  }

  cpu {
    cores = var.vcpu
  }

  memory {
    dedicated = var.memory
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

resource "proxmox_virtual_environment_container" "lxc2" {
  description  = "LXC Container - ${var.lxc_names[1]}"
  node_name    = var.proxmox_node
  unprivileged = true
  started      = false

  initialization {
    hostname = var.lxc_names[1]

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
    template_file_id = "local:vztmpl/debian-12-standard_12.12_1_amd64.tar.zst"
    type             = "debian"
  }

  cpu {
    cores = var.vcpu
  }

  memory {
    dedicated = var.memory
    swap       = 512
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