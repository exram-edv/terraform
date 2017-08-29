provider "azurerm" {
  subscription_id = "${var.provider_azurerm_subscription_id}"
  client_id       = "${var.provider_azurerm_client_id}"
  client_secret   = "${var.provider_azurerm_client_secret}"
  tenant_id       = "${var.provider_azurerm_tenant_id}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.deployment_region_name}_${var.deployment_env}_${var.deployment_cluster_name}"
  location = "${var.deployment_region}"
}
