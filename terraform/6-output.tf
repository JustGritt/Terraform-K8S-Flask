output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw
  sensitive = true
}

resource "null_resource" "get_public_ip" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "kubectl get service external-ingress-nginx-controller -n ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}' > public_ip.txt"
  }

  depends_on = [azurerm_kubernetes_cluster.example]
}

output "public_ip" {
  value     = "${trimspace(file("public_ip.txt"))}"
  sensitive = true
}