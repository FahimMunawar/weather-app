terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  required_version = ">= 1.3.1"
}

data "azurerm_client_config" "current" {
}

resource "azurerm_user_assigned_identity" "aks_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  name = "${var.name}Identity"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  kubernetes_version        = var.kubernetes_version
  dns_prefix                = var.dns_prefix
  private_cluster_enabled   = var.private_cluster_enabled
  automatic_channel_upgrade = var.automatic_channel_upgrade
  sku_tier                  = var.sku_tier
  azure_policy_enabled      = var.azure_policy.enabled

  default_node_pool {
    name           = var.default_node_pool_name
    vm_size        = var.default_node_pool_vm_size
    vnet_subnet_id = var.vnet_subnet_id
    zones          = var.default_node_pool_availability_zones
    max_pods       = var.default_node_pool_max_pods
    node_count     = var.default_node_pool_node_count
    tags           = var.tags
    upgrade_settings {
      max_surge = "10%"
    }
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    docker_bridge_cidr = var.network_docker_bridge_cidr
    dns_service_ip     = var.network_dns_service_ip
    network_plugin     = var.network_plugin
    service_cidr       = var.network_service_cidr
  }


  lifecycle {
    ignore_changes = [
      kubernetes_version,
      tags
    ]
  }
}
