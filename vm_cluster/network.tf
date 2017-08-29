resource "azurerm_network_security_group" "firewall" {
  name                = "${azurerm_resource_group.rg.name}_firewall"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.deployment_region}"
}

resource "azurerm_network_security_rule" "node-ssh" {
    name                        = "node-ssh"
    resource_group_name         = "${azurerm_resource_group.rg.name}"
    network_security_group_name = "${azurerm_network_security_group.firewall.name}"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    priority                    = "100"
    access                      = "Allow"
    direction                   = "Inbound"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${azurerm_resource_group.rg.name}_vnet"
  address_space       = ["${var.net_cidr}"]
  location            = "${var.deployment_region}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_subnet" "subnet" {
  name                      = "cluster_subnet"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "${var.net_subnet_cidr}"
  network_security_group_id = "${azurerm_network_security_group.firewall.id}"
}

resource "azurerm_public_ip" "public_ip" {
  name                         = "${azurerm_resource_group.rg.name}_node${count.index}_public_ip"
  location                     = "${var.deployment_region}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "${var.net_public_ip_allocation}"

  count = "${var.deployment_cluster_node_count}"
}

resource "azurerm_network_interface" "nic" {
  name                = "${azurerm_resource_group.rg.name}_node${count.index}_nic"
  location            = "${var.deployment_region}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "${azurerm_resource_group.rg.name}_node${count.index}_nic_ip_configuration"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.public_ip.*.id, count.index)}"
  }

  count = "${var.deployment_cluster_node_count}"
}