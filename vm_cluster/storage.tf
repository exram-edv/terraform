/*******************************************************************************************
* add storage account
*******************************************************************************************/
resource "azurerm_storage_account" "storage" {
  name                = "exram-${var.deployment_cluster_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.deployment_region}"
  account_type        = "Standard_LRS"
}

/*******************************************************************************************
* create fileshares 
*******************************************************************************************/
resource "azurerm_storage_share" "clusterdata" {
  name                 = "${var.storage_share_clusterdata}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  storage_account_name = "${azurerm_storage_account.storage.name}"
}

