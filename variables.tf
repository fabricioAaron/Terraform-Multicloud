# Variables Globales
variable "project_name" {
  type        = string
  description = "Prefijo para los recursos del proyecto"
  default     = "proyectmulticloud"
}

# Variables de Azure
variable "azure_location" {
  type        = string
  description = "Región de Azure donde se desplegarán los recursos"
  default     = "Spain Central"
}

# Variables de AWS
variable "aws_region" {
  type        = string
  description = "Región de AWS donde se desplegará el bucket S3"
  default     = "us-east-1"
}
