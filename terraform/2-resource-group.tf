# Main resource group
resource "azurerm_resource_group" "rg_flask" {
    name     = local.resource_group
    location = local.region
    tags = {
        environment = "Terraform Lab"
    }
}