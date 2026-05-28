terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.71.0"
    }
  }
}

locals {
  disk_value  = tonumber(substr(var.disk_size, 0, length(var.disk_size) - 1))
  disk_unit   = substr(var.disk_size, length(var.disk_size) - 1, 1)
  disk_gb     = local.disk_unit == "M" ? ceil(local.disk_value / 1024) : local.disk_value
  pkg_install = length(var.ansible_packages) > 0 ? join(" ", var.ansible_packages) : ""
  root_login  = var.allow_root_login ? "yes" : "prohibit-password"
}

resource "proxmox_virtual_environment_file" "ansible_hook_script" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.proxmox_node

  source_raw {
    data = <<-SCRIPT
#!/bin/sh
set -e
if [ "$1" = "post-start" ]; then
  pct exec $3 -- bash -c "apt-get update -qq && apt-get install -y -qq python3 ${local.pkg_install}"
  pct exec $3 -- bash -c "sed -i 's/^#PermitRootLogin.*/PermitRootLogin ${local.root_login}/' /etc/ssh/sshd_config && sed -i 's/^PermitRootLogin.*/PermitRootLogin ${local.root_login}/' /etc/ssh/sshd_config"
  pct exec $3 -- systemctl restart sshd
fi
SCRIPT
    file_name = "ansible-hook-script.sh"
  }

  file_mode = "0755"
}

resource "proxmox_virtual_environment_container" "lxc" {
  for_each = toset(var.lxc_names)

  description         = "LXC Container - ${each.value} (Ansible-ready)"
  node_name           = var.proxmox_node
  unprivileged        = true
  started             = true
  tags                = ["terraform", var.lxc_project, "ansible-ready"]
  hook_script_file_id = proxmox_virtual_environment_file.ansible_hook_script.id

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

  features {
    nesting = true
  }

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
