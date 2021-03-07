# Configure the Azure provider
provider "azurerm" { 
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

#Create the blob storage backend in Azure before running this
#Export access key and store in ARM_ACCESS_KEY
#This block cannot read from tfvars as this is assoicated with a provider
terraform {
  backend "azurerm" {
    resource_group_name   = "rg-experiments-sea"
    storage_account_name  = "terraformblobstoragedev"
    container_name        = "terraform"
    key                   = "terraform.tfstate"
    
  }
}
resource "azurerm_kubernetes_cluster" "aks" {
  dns_prefix          = var.dns
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  location            = var.location
  name                = var.clustername
  node_resource_group = "${azurerm_resource_group.primary.name}-aks"
  resource_group_name = var.resource_group_name

  addon_profile {
    azure_policy { enabled = true }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
    }
  }

  default_node_pool {
    availability_zones   = [1, 2, 3]
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    name                 = "system"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    os_disk_size_gb      = 1024
    vm_size              = "Standard_DS2_v2"
  }

  identity { type = "SystemAssigned" }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed                = true
      admin_group_object_ids = [azuread_group.aks_administrators.object_id]
    }
  }
}