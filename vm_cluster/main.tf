resource "azurerm_resource_group" "rg" {
  name     = "${var.deployment_region_name}_${var.deployment_env}_${var.deployment_cluster_name}"
  location = "${var.deployment_region}"
}
