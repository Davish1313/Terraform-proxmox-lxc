# Terraform Proxmox LXC

Terraform configuration to create LXC containers in Proxmox VE.

---

## Proxmox LXC con Terraform

Configuración de Terraform para crear contenedores LXC en Proxmox VE.

## Prerequisites / Prerrequisitos

- Terraform >= 1.0
- Proxmox VE >= 7.0
- Proxmox API Token

## Setup / Configuración

1. Copy the example file / Copiar el archivo de ejemplo:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values:
   - `pm_api_url`: Your Proxmox server URL
   - `pm_api_token_id`: Your API token (format: `user@pve!token=uuid`)
   - Other parameters as needed.

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Verify plan:
   ```bash
   terraform plan
   ```

5. Apply:
   ```bash
   terraform apply
   ```

## File Structure / Estructura de Archivos

| File | Description |
|------|-------------|
| `main.tf` | LXC resources to create |
| `variables.tf` | Variable definitions |
| `outputs.tf` | Module outputs |
| `providers.tf` | Provider configuration |
| `terraform.tfvars` | Variables (do not version) |

## Resources Created / Recursos Creados

- 2 Debian 12 LXC containers
- CPU, memory and disk configuration
- Network interface on specified bridge
- User with password and SSH key

## Cleanup / Limpiar

```bash
terraform destroy
```
