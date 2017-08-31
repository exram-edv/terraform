output "node_names" {
    value = ["${azurerm_virtual_machine.vm.*.name}"]
}

output "node_public_ips" {
    value = ["${azurerm_public_ip.public_ip.*.ip_address}"]
}