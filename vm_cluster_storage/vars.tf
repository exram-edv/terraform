# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR DEPLOYMENT SETTINGS 
# ---------------------------------------------------------------------------------------------------------------------
variable "deployment_region" {
    default = "West Europe"
    description = "Where to deploy the Rancher-Cluster"
    }
variable "deployment_cluster_name" {
    description = "name of the cluster"
    }
variable "deployment_rg_name" {
    description = "name of the resource group"
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR OS
# ---------------------------------------------------------------------------------------------------------------------
variable "os_admin_username" {}
variable "os_admin_password" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR CLUSTER
# ---------------------------------------------------------------------------------------------------------------------
variable "cluster_node_ids" {
    type = "list"
    default = []
    description = "list of vm-id´s for cluster nodes"
}
variable "cluster_node_public_ips" {
    type = "list"
    default = []
    description = "list of public-ip´s for cluster nodes"
}
variable "cluster_node_ssh_ports" {
    type = "list"
    default = ["22"]
    description = "list of ssh-ports for nodes"
}
variable "cluster_node_count" {
    default = 1
    description = "number of nodes in the cluster"
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR SHARED STORAGE
# ---------------------------------------------------------------------------------------------------------------------
variable "storage_share_clusterdata" {
    description = "Share to mount into nodes for cluster data"
    default     = "clusterdata"
    }

