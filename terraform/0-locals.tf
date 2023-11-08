locals {
    # Resource Group
    resource_group = "rg-ESGI-atan"
    region = "francecentral"

    # Container Registry
    container_registry_name = "flaskregistryesgi5iw3"
    container_registry_sku = "Standard"

    # Kubernetes Cluster
    kubernetes_cluster_name = ""
    kubernetes_cluster_node_vm_size = "Standard_B2s"
}