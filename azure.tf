# Grupo de Recursos en Azure
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.azure_location
}

# Sufijo aleatorio para que el nombre del Storage Account sea único (requiere ser único a nivel global)
#esource "random_string" "storage_suffix" {
# length  = 6
# special = false
# upper   = false
#

# Cuenta de Almacenamiento (Storage Account)
resource "azurerm_storage_account" "storage" {
  name                     = var.project_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Contenedor para guardar archivos (equivalente al S3 Bucket en Azure)
resource "azurerm_storage_container" "container" {
  name                  = "archivos-proyecto"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
