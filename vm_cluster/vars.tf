# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR AZURE ACCOUNT
# ---------------------------------------------------------------------------------------------------------------------
variable "provider_azurerm_subscription_id" {}
variable "provider_azurerm_client_id" {}
variable "provider_azurerm_client_secret" {}
variable "provider_azurerm_tenant_id" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR DEPLOYMENT SETTINGS 
# ---------------------------------------------------------------------------------------------------------------------
variable "deployment_region" {
    default = "West Europe"
    description = "Where to deploy the Rancher-Cluster"
    }
variable "deployment_region_name" {
    default     = "euw"
    description = "shortname for the region"
    }
variable "deployment_cluster_name" {
    description = "name of the cluster"
    }
variable "deployment_cluster_node_count" {
    default = 1
    description = "number of cluster nodes"
    }
variable "deployment_env" {
    description = "shortname for environment (prod, dev, test)"
    }

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR VIRTUAL NETWORK 
# ---------------------------------------------------------------------------------------------------------------------
variable "net_cidr" {
    default = "10.0.0.0/16"
    description = "address-space for virtual network"
}    
variable "net_subnet_cidr" {
    default = "10.0.2.0/24"
    description = "address-space for virtual network"
}    
variable "net_public_ip_allocation" {
    default = "static"
    description = "type of IP allocation (static / dynamic)"
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR VMs 
# ---------------------------------------------------------------------------------------------------------------------
variable "vm_size" {
    default = "Standard_DS1_v2"
    description = "size of the node vm´s"
}
variable "vm_image_publisher" {
    default = "Canonical"
    description = "publisher of the os image"
}
variable "vm_image_offer" {
    default = "UbuntuServer"
    description = "offer for the os image"
}
variable "vm_image_sku" {
    default = "16.04-LTS"
    description = "sku for the os image"
}
variable "vm_image_version" {
    default = "latest"
    description = "version for the os image"
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR OS
# ---------------------------------------------------------------------------------------------------------------------
variable "os_admin_username" {}
variable "os_admin_password" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR SHARED STORAGE
# ---------------------------------------------------------------------------------------------------------------------
variable "storage" {
    default = false
    description = "initialize shared file storage on all nodes"
}
variable "storage_share_clusterdata" {
    description = "Share to mount into nodes for cluster data"
    default     = "cluster_data"
    }
