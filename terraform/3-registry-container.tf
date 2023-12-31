# Main registry container
resource "azurerm_container_registry" "acr" {
    name                     = local.container_registry_name
    resource_group_name      = azurerm_resource_group.rg_flask.name
    location                 = azurerm_resource_group.rg_flask.location
    sku                      = local.container_registry_sku
    admin_enabled            = false
}