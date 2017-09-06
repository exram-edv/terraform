output "rg_name" {
    value = "${azurerm_resource_group.rg.name}"
}

output "node_names" {
    value = ["${azurerm_virtual_machine.vm.*.name}"]
}

output "node_ids" {
    value = ["${azurerm_virtual_machine.vm.*.id}"]
}

output "node_public_ips" {
    value = ["${azurerm_public_ip.public_ip.*.ip_address}"]
}

output "firewall_name" {
    value = "${azurerm_network_security_group.firewall.name}"
}