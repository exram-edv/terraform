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
# VARIABLE-DEFINITION FOR PROVISIONING
# ---------------------------------------------------------------------------------------------------------------------
variable "provision_script_path" {
    default = ""
    description = "Path to the additional provisioning script"
}
variable "provision_script_file" {
    default = "provision.sh"
    description = "Filename for additional provisioning script"
}

