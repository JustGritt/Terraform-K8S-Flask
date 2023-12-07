# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {}
}

# Azure Provider source and version being used
terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=3.83.0"
        }
        helm = {
            source  = "hashicorp/helm"
            version = ">= 2.1.0"
        }
        azuread = {
            source  = "hashicorp/azuread"
            version = "~> 2.15.0"
        }
    }
}


