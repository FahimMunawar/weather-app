location            = "uksouth"
resource_group_name = "test-rg"
tags = {
  enviornment = "test",
  createdWith = "Terraform"
}
aks_vnet_address_space                  = ["10.23.0.0/16"]
default_node_pool_subnet_address_prefix = ["10.23.0.0/21"]
resource_subnet_address_prefix          = ["10.23.8.0/21"]
aks_cluster_name                        = "test-aks"
kubernetes_version                      = "1.31.8"
default_node_pool_vm_size               = "Standard_B4ms"
default_node_pool_enable_auto_scaling   = false
default_node_pool_node_count            = 4
backup_retention                        = 7