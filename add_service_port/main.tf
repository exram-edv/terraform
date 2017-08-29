/*******************************************************************************************
* Add a TCP-Port for a service to a loadbalanced cluster
*
* Variables
*   - port_name
*   - frontend_port_value
*   - backend_port_value
*   - resource_group_name
*   - network_security_group_name
*   - priority
*   - loadbalancer_id
*   - frontend_ip_configuration_name
*   - backend_address_pool_id
*
* Resources
*   - add Firewall-Rule for Ports to cluster subnet
*   - add Loadbalancer probe for service-port
*   - add Loadbalancer-Rule for service-port
*
* Outputs
*
*******************************************************************************************/

/*******************************************************************************************
* Variables
*******************************************************************************************/
variable "port_name" {}
variable "frontend_port_value" {}
variable "backend_port_value" {}
variable "resource_group_name" {}
variable "network_security_group_name" {}
variable "priority" {}
variable "loadbalancer_id" {}
variable "frontend_ip_configuration_name" {}
variable "backend_address_pool_id" {}
    
/*******************************************************************************************
* add Firewall-Rule for Ports to cluster subnet
*******************************************************************************************/
resource "azurerm_network_security_rule" "fw_rule" {
    name                        = "${var.port_name}"
    resource_group_name         = "${var.resource_group_name}"
    network_security_group_name = "${var.network_security_group_name}"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "${var.frontend_port_value}"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    priority                    = "${var.priority}"
    access                      = "Allow"
    direction                   = "Inbound"
}

/*******************************************************************************************
* add Loadbalancer probe for service-port
*******************************************************************************************/
resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "${var.port_name}-open-probe"
  port                = "${var.frontend_port_value}"
  protocol            = "Tcp"
  interval_in_seconds = 30
  number_of_probes    = 2
}

/*******************************************************************************************
* add Loadbalancer-Rule for Services
*******************************************************************************************/
resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = "${var.resource_group_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "${var.port_name}"
  protocol                       = "Tcp"
  frontend_port                  = "${var.frontend_port_value}"
  backend_port                   = "${var.backend_port_value}"
  frontend_ip_configuration_name = "${var.frontend_ip_configuration_name}"
  probe_id                       = "${azurerm_lb_probe.lb_probe.id}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  load_distribution              = "Default"
}