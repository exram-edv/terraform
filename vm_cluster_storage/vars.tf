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
    description = "list of vm-id´s for cluster nodes"
}
variable "cluster_node_public_ips" {
    type = "list"
    description = "list of public-ip´s for cluster nodes"
}
variable "cluster_node_ssh_ports" {
    type = "list"
    default = ["22"]
    description = "list of ssh-ports for nodes"
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR SHARED STORAGE
# ---------------------------------------------------------------------------------------------------------------------
variable "storage_share_clusterdata" {
    description = "Share to mount into nodes for cluster data"
    default     = "clusterdata"
    }

