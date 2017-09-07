output "share" {
    value = "${var.storage_share}"
}
output "account" {
    value = "${var.storage_account == "" ? azurerm_storage_account.storage.name : var.storage_account}"
}
output "key" {
    value = "${var.storage_key == "" ? azurerm_storage_account.storage.primary_access_key : var.storage_key}"
}