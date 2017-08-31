/*******************************************************************************************
* add storage account
*******************************************************************************************/
resource "azurerm_storage_account" "storage" {
  name                = "exram${var.deployment_cluster_name}"
  resource_group_name = "${var.deployment_rg_name}"
  location            = "${var.deployment_region}"
  account_type        = "Standard_LRS"
}

/*******************************************************************************************
* create fileshares 
*******************************************************************************************/
resource "azurerm_storage_share" "clusterdata" {
  name                 = "${var.storage_share_clusterdata}"
  resource_group_name  = "${var.deployment_rg_name}"
  storage_account_name = "${azurerm_storage_account.storage.name}"
}

/*******************************************************************************************
* read template for mount script, add storage account data and save script as mount.sh 
*******************************************************************************************/
data "template_file" "mount" {
  template = "${file("${path.module}/provisioning/mount.tpl")}"

  vars {
    storage_account = "${azurerm_storage_account.storage.name}"  
    storage_key     = "${azurerm_storage_account.storage.primary_access_key}"
    storage_share   = "${var.storage_share_clusterdata}"
  }
}

resource "local_file" "mount" {
    content  = "${data.template_file.mount.rendered}"
    filename = "${path.cwd}/provisioning/mount.sh"
}

/*******************************************************************************************
* Provision shared storage to each node with mount.sh
*******************************************************************************************/
 module "storage_provisioning" {
    source = "github.com/exram-edv/terraform//vm_cluster_provisioning"

    depends_on = ["local_file.mount"]

    cluster_node_ids        = "${var.cluster_node_ids}"
    cluster_node_public_ips = "${var.cluster_node_public_ips}"

    provision_script_path = "${path.cwd}/provisioning"
    provision_script_file = "mount.sh"

    os_admin_username = "${var.os_admin_username}"
    os_admin_password = "${var.os_admin_password}"
 }