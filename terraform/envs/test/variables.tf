variable "location" {
  description = "Specifies the location for the resource group and all the resources"
  default     = "uksouth"
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the resource group name"
  default     = "test-system-rg"
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  default = {
    createdWith = "Terraform"
  }
}

variable "aks_vnet_name" {
  description = "Specifies the name of the AKS subnet"
  default     = "test-vnet"
  type        = string
}

variable "aks_vnet_address_space" {
  description = "Specifies the address prefix of the AKS subnet"
  default     = ["10.5.0.0/16"]
  type        = list(string)
}

variable "default_node_pool_subnet_name" {
  description = "Specifies the name of the subnet that hosts the default node pool"
  default     = "aks-subnet"
  type        = string
}

variable "default_node_pool_subnet_address_prefix" {
  description = "Specifies the address prefix of the subnet that hosts the default node pool"
  default     = ["10.5.0.0/21"]
  type        = list(string)
}

variable "resource_subnet_name" {
  description = "Specifies the name of the jumpbox subnet"
  default     = "resource-subnet"
  type        = string
}

variable "resource_subnet_address_prefix" {
  description = "Specifies the address prefix of the jumbox subnet"
  default     = ["10.5.8.0/21"]
  type        = list(string)
}

variable "aks_cluster_name" {
  description = "(Required) Specifies the name of the AKS cluster."
  default     = "test-aks"
  type        = string
}

variable "kubernetes_version" {
  description = "Specifies the AKS Kubernetes version"
  default     = "1.28.5"
  type        = string
}

variable "automatic_channel_upgrade" {
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, and stable."
  default     = "stable"
  type        = string

  validation {
    condition     = contains(["patch", "rapid", "stable"], var.automatic_channel_upgrade)
    error_message = "The upgrade mode is invalid."
  }
}

variable "sku_tier" {
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
  default     = "Free"
  type        = string

  validation {
    condition     = contains(["Free", "Paid"], var.sku_tier)
    error_message = "The sku tier is invalid."
  }
}

variable "default_node_pool_name" {
  description = "Specifies the name of the default node pool"
  default     = "system"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "Specifies the vm size of the default node pool"
  default     = "Standard_B4ms"
  type        = string
}

variable "default_node_pool_availability_zones" {
  description = "Specifies the availability zones of the default node pool"
  default     = ["1", "2"]
  type        = list(string)
}

variable "default_node_pool_node_labels" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type        = map(any)
  default     = {}
}

variable "default_node_pool_node_taints" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type        = list(string)
  default     = []
}

variable "default_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type        = bool
  default     = true
}

variable "default_node_pool_enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "default_node_pool_enable_node_public_ip" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "default_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 250
}

variable "default_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type        = string
  default     = "Managed"
}

variable "default_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type        = number
  default     = 15
}

variable "default_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type        = number
  default     = 2
}

variable "default_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type        = number
  default     = 4
}

variable "network_docker_bridge_cidr" {
  description = "Specifies the Docker bridge CIDR"
  default     = "172.17.0.1/16"
  type        = string
}

variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP"
  default     = "10.2.0.10"
  type        = string
}

variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string
}

variable "network_service_cidr" {
  description = "Specifies the service CIDR"
  default     = "10.2.0.0/24"
  type        = string
}

variable "role_based_access_control_enabled" {
  description = "(Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created."
  default     = true
  type        = bool
}

variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = ["ccb5c98e-c52e-4145-a60d-3ca45e971884"]
  type        = list(string)
}

variable "azure_rbac_enabled" {
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = true
  type        = bool
}

variable "admin_username" {
  description = "(Required) Specifies the admin username of the jumpbox virtual machine and AKS worker nodes."
  type        = string
  default     = "azclusteradmin"
}

variable "ssh_public_key" {
  description = "(Required) Specifies the SSH public key for the AKS worker nodes."
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNwZcFzsRZKbXXA4RzUOlEAjkbFAeKJ0sj04yDtl5QULpliZwnUUMpyomR4abuzW9V/KMwDV8Wqj/oE/yBL01hEOu6MURLqFZ6PqK/tSpcqrqoD4H1DK+uzddvmkmfSga0dV/kzixURGo3SJjfyRYkXshhFbg3jLStyCkU4Hi3Q9Dj6QyP7920GHdPEs0FZp5dcHiAWdQrwQtibvJYniDs0sjppeqVmi+y6UYc0JkMaXf8QY8xsYUmR7/GT6vkaUm7MqgCB54+IagpiyqF8V1Y/pr3YyL0sMbWl/s+Tfz/6FjV4M0i9fKk8PTxsg499f9suAmj23/EbUMr7d5Rp5+UhAbnRX4oFKCWiFWYoRvAdG0U6rX820yQTyQnKsrk3DHH5omdO8kpcUuiMCs32ddMmqlzIhQ01s9+2iQOhHcNipJHLamlpW7UkHJL/HhP446GEG69pFi/uJJGIx7gAd9UBpGC+yIP0rSBDGkAfPHOEqdZjsWq5bpkRXFp2tX549AjLvBKMlo5ZZd7Sj8ZAzckSu2MAqJdEHM0NaQf2Ocxs9txr0mywz+flmGA6FXA7C6mheSA7k/s4WmWDXGcGlA93w7FoWZGOQ6VjQloXdjojhkQuTHWkK2Ctu990xYogbooqay/epWiIz2Hh1k5qVTiC+3jMjGSBS1WNdA6Eg95oQ== munawar@munawar"
}


variable "hub_address_space" {
  description = "Specifies the address space of the hub virtual virtual network"
  default     = ["10.1.0.0/16"]
  type        = list(string)
}

variable "hub_vnet_name" {
  description = "Specifies the name of the hub virtual virtual network"
  default     = "HubVNet"
  type        = string
}
variable "hub_firewall_subnet_address_prefix" {
  description = "Specifies the address prefix of the firewall subnet"
  default     = ["10.1.0.0/24"]
  type        = list(string)
}


variable "backup_retention" {
  type        = number
  description = "(optional) backup_retention in days"
}