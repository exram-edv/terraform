# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR AZURE ACCOUNT
# ---------------------------------------------------------------------------------------------------------------------
variable "provider_azurerm_subscription_id" {}
variable "provider_azurerm_client_id" {}
variable "provider_azurerm_client_secret" {}
variable "provider_azurerm_tenant_id" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR OS
# ---------------------------------------------------------------------------------------------------------------------
variable "os_admin_username" {}
variable "os_admin_password" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLE-DEFINITION FOR PROVISIONING
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
variable "cluster_is_lb" {
    default = false
    description = "set to true if the cluster is loadbalanced"
}

variable "provision_script_path" {
    default = ""
    description = "Path to the additional provisioning script"
}
variable "provision_script_file" {
    default = "provision.sh"
    description = "Filename for additional provisioning script"
}
