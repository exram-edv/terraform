resource "azurerm_availability_set" "as" {
  name                = "${azurerm_resource_group.rg.name}_as"
  location            = "${var.deployment_region}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  managed             = true
}

resource "azurerm_virtual_machine" "vm" {
  name                          = "${azurerm_resource_group.rg.name}_node${count.index}_vm"
  location                      = "${var.deployment_region}"
  resource_group_name           = "${azurerm_resource_group.rg.name}"
  availability_set_id           = "${azurerm_availability_set.as.id}"
  network_interface_ids         = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  vm_size                       = "${var.vm_size}"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "${var.vm_image_publisher}"
    offer     = "${var.vm_image_offer}"
    sku       = "${var.vm_image_sku}"
    version   = "${var.vm_image_version}"
  }

  storage_os_disk {
    name              = "${azurerm_resource_group.rg.name}_node${count.index}_os_disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "node${count.index}"
    admin_username = "${var.os_admin_username}"
    admin_password = "${var.os_admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  provisioner "file" {
    source = "${path.module}/provisioning/provision.sh"
    destination = "/home/${var.os_admin_username}/provision.sh"

    connection {
      type        = "ssh"
      host        = "${element(azurerm_public_ip.public_ip.*.ip_address, count.index)}"
      user        = "${var.os_admin_username}"
      password    = "${var.os_admin_password}"
    }
  }
    
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y install dos2unix",
      "sudo dos2unix /home/${var.os_admin_username}/provision.sh",
      "chmod +x /home/${var.os_admin_username}/provision.sh",
      "/home/${var.os_admin_username}/provision.sh ${azurerm_storage_account.storage.name} ${azurerm_storage_account.storage.primary_access_key} ${var.storage_share_clusterdata}",
    ]

    connection {
      type        = "ssh"
      host        = "${element(azurerm_public_ip.public_ip.*.ip_address, count.index)}"
      user        = "${var.os_admin_username}"
      password    = "${var.os_admin_password}"
    }
  }

  count = "${var.deployment_cluster_node_count}"
}