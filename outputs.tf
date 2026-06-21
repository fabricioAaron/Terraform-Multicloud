# Azure Outputs
output "azure_storage_account_name" {
  description = "Nombre de la Cuenta de Almacenamiento en Azure"
  value       = azurerm_storage_account.storage.name
}

output "azure_container_name" {
  description = "Nombre del Contenedor dentro de la Cuenta de Almacenamiento"
  value       = azurerm_storage_container.container.name
}

# AWS Outputs
output "aws_s3_bucket_name" {
  description = "Nombre del bucket S3 creado en AWS"
  value       = aws_s3_bucket.portfolio_bucket.id
}
