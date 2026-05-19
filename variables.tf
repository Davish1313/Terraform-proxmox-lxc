variable "pm_api_url" {
  description = "URL de la API de Proxmox"
  type        = string
}

variable "pm_api_token_id" {
  description = "ID del token API"
  type        = string
}

#variable "pm_api_token_secret" {
#  description = "Secreto del token API"
#  type        = string
#  sensitive   = true
#}

variable "proxmox_node" {
  description = "Nodo de Proxmox donde crear los LXC"
  type        = string
}

variable "proxmox_storage" {
  description = "Almacenamiento a usar"
  type        = string
}

variable "lxc_names" {
  description = "Lista de nombres para los LXC"
  type        = list(string)
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

variable "ssh_port" {
  description = "Puerto SSH interno de los LXC"
  type        = number
  default     = 22
}

variable "bridge" {
  description = "Bridge de red"
  type        = string
}

variable "vcpu" {
  description = "Número de vCPUs"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Memoria RAM en MB"
  type        = number
  default     = 512
}

variable "disk_size" {
  description = "Tamaño del disco en GB"
  type        = string
  default     = "4G"
}

variable "os_template" {
  description = "Template del sistema operativo"
  type        = string
  default     = "debian-12-standard"
}
