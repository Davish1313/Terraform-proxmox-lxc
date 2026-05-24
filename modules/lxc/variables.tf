variable "lxc_names" {
  description = "Lista de nombres para los LXC"
  type        = list(string)
  validation {
    condition     = length(var.lxc_names) > 0
    error_message = "Debe especificar al menos un LXC"
  }
}

variable "proxmox_node" {
  description = "Nodo de Proxmox donde crear los LXC"
  type        = string
}

variable "proxmox_storage" {
  description = "Almacenamiento a usar"
  type        = string
}

variable "lxc_password" {
  description = "Password root para los LXC"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "Clave pública SSH"
  type        = string
}

variable "bridge" {
  description = "Bridge de red"
  type        = string
}

variable "vcpu" {
  description = "Número de vCPUs"
  type        = number
  default     = 1
  validation {
    condition     = var.vcpu >= 1 && var.vcpu <= 16
    error_message = "vCPU debe estar entre 1 y 16"
  }
}

variable "memory" {
  description = "Memoria RAM en MB"
  type        = number
  default     = 512
  validation {
    condition     = var.memory >= 128 && var.memory <= 65536
    error_message = "Memory debe estar entre 128MB y 64GB"
  }
}

variable "disk_size" {
  description = "Tamaño del disco (ej: 4G, 8G, 16G)"
  type        = string
  default     = "4G"
  validation {
    condition     = can(regex("^[0-9]+[GM]$", var.disk_size))
    error_message = "Disk size debe ser formato número seguido de G o M (ej: 4G, 512M)"
  }
}

variable "os_template" {
  description = "Template del sistema operativo (sin extensión .tar.zst)"
  type        = string
  default     = "debian-12-standard_12.12_1_amd64"
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.os_template))
    error_message = "El nombre del template solo puede contener letras, números, guiones y guiones bajos"
  }
}

variable "ansible_packages" {
  description = "Paquetes adicionales para preparación Ansible (python3 ya incluido en Debian 12)"
  type        = list(string)
  default     = []
}

variable "lxc_project" {
  description = "Nombre del proyecto para tags"
  type        = string
  default     = "terraform-lxc"
}
