/*******************************************************************************************
* neuen Storage account anlegen, wenn keine Daten für einen bestehenden Account angegeben wurden 
*******************************************************************************************/
resource "azurerm_storage_account" "storage" {
    count = "${var.storage_account == "" ? 1 : 0}"

    name                = "exram${var.deployment_cluster_name}"
    resource_group_name = "${var.deployment_rg_name}"
    location            = "${var.deployment_region}"
    account_type        = "Standard_LRS"
}

/*******************************************************************************************
* fileshare für shared storage anlegen
*******************************************************************************************/
resource "azurerm_storage_share" "clusterdata" {
  name                 = "${var.storage_share}"
  resource_group_name  = "${var.deployment_rg_name}"
  storage_account_name = "${var.storage_account == "" ? "${azurerm_storage_account.storage.name}" : var.storage_account}"
}

/*******************************************************************************************
* read template for mount script, add storage account data and save script as mount.sh 
*******************************************************************************************/
data "template_file" "mount" {
  template = "${file("${path.module}/provisioning/mount.tpl")}"


  vars {
    storage_account = "${var.storage_account == "" ? "${azurerm_storage_account.storage.name}" : var.storage_account}" 
    storage_key     = "${var.storage_key == "" ? "${azurerm_storage_account.storage.primary_access_key}" : var.storage_key}"
    storage_share   = "${var.storage_share}"
  }
}

resource "local_file" "mount" {
    content  = "${data.template_file.mount.rendered}"
    filename = "${path.cwd}/provisioning/mount.sh"
}

/*******************************************************************************************
* Provision shared storage to each node with mount.sh
*******************************************************************************************/
resource "null_resource" "cluster_storage" {
    count = "${var.cluster_node_count}"
    depends_on = ["local_file.mount"]

    triggers {
        node_ids ="${element(var.cluster_node_ids, count.index)}"
    }

    provisioner "file" {
        source = "${path.cwd}/provisioning/mount.sh"
        destination = "/home/${var.os_admin_username}/mount.sh"

        connection {
            type        = "ssh"
            host        = "${element(var.cluster_node_public_ips, count.index)}"
            port        = "${element(var.cluster_node_ssh_ports, count.index)}"
            user        = "${var.os_admin_username}"
            password    = "${var.os_admin_password}"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y install dos2unix",
            "sudo dos2unix /home/${var.os_admin_username}/mount.sh",
            "chmod +x /home/${var.os_admin_username}/mount.sh",
            "/home/${var.os_admin_username}/mount.sh",
        ]

        connection {
            type        = "ssh"
            host        = "${element(var.cluster_node_public_ips, count.index)}"
            port        = "${element(var.cluster_node_ssh_ports, count.index)}"
            user        = "${var.os_admin_username}"
            password    = "${var.os_admin_password}"
        }
    }
}