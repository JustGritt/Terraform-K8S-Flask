resource "azurerm_kubernetes_cluster" "example" {
    name                = local.kubernetes_name
    location            = azurerm_resource_group.rg_flask.location
    resource_group_name = azurerm_resource_group.rg_flask.name
    dns_prefix          = "exampleaks1"

    default_node_pool {
        name       = local.kubernetes_cluster_name
        node_count = 1
        vm_size    = local.kubernetes_cluster_node_vm_size
    }

    identity {
        type = "SystemAssigned"
    }

    tags = {
        Environment = "Development"
    }
}

data "azuread_client_config" "current" {}

resource "azurerm_role_assignment" "acr_push" {
    scope                = azurerm_container_registry.acr.id
    role_definition_name = "AcrPush"
    principal_id         = data.azuread_client_config.current.object_id
    depends_on           = [azurerm_kubernetes_cluster.example]
}

resource "azurerm_role_assignment" "acr_pull" {
    scope                = azurerm_container_registry.acr.id
    role_definition_name = "AcrPull"
    principal_id         =  azurerm_kubernetes_cluster.example.kubelet_identity[0].object_id
    depends_on           = [azurerm_kubernetes_cluster.example]
}


