provider "azurerm" {
  subscription_id = "${var.provider_azurerm_subscription_id}"
  client_id       = "${var.provider_azurerm_client_id}"
  client_secret   = "${var.provider_azurerm_client_secret}"
  tenant_id       = "${var.provider_azurerm_tenant_id}"
}

resource "null_resource" "cluster" {
    count = "${length(var.cluster_node_ids)}"

    triggers {
        node_ids ="${element(var.cluster_node_ids, count.index)}"
    }

    provisioner "file" {
        source = "${var.provision_script_path}/${var.provision_script_file}"
        destination = "/home/${var.os_admin_username}/${var.provision_script_file}"

        connection {
            type        = "ssh"
            host        = "${element(var.cluster_node_public_ips, count.index)}"
            user        = "${var.os_admin_username}"
            password    = "${var.os_admin_password}"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y install dos2unix",
            "sudo dos2unix /home/${var.os_admin_username}/${var.provision_script_file}",
            "chmod +x /home/${var.os_admin_username}/${var.provision_script_file}",
            "/home/${var.os_admin_username}/${var.provision_script_file} ${count.index}",
        ]

        connection {
            type        = "ssh"
            host        = "${element(var.cluster_node_public_ips, count.index)}"
            user        = "${var.os_admin_username}"
            password    = "${var.os_admin_passpord}"
        }
    }
}