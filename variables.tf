# Variables Globales
variable "environment" {
  type        = string
  description = "Entorno de despliegue (dev, staging, prod)"
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser dev, staging o prod."
  }
}

variable "project_name" {
  type        = string
  description = "Prefijo para los recursos del proyecto"
  default     = "proyectmulticloud"

  validation {
    condition     = length(var.project_name) > 3 && length(var.project_name) <= 24
    error_message = "El nombre del proyecto debe tener entre 4 y 24 caracteres."
  }
}

# Variables de Azure
variable "azure_location" {
  type        = string
  description = "Región de Azure donde se desplegarán los recursos"
  default     = "Spain Central"

  validation {
    condition     = length(var.azure_location) > 0
    error_message = "La región de Azure no puede estar vacía."
  }
}

# Variables de AWS
variable "aws_region" {
  type        = string
  description = "Región de AWS donde se desplegará el bucket S3"
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "La región de AWS debe tener un formato válido, por ejemplo: us-east-1."
  }
}
