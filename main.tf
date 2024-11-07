
locals {
  location= "North Europe"
  ResourceGroup= "myGroup"
}

resource "azurerm_resource_group" "myRG" {
  name = "myGroup"
  location = "North Europe"
}
/*
resource "azurerm_windows_virtual_machine" "SQLVM" {
  name                = "SQLVM"
  resource_group_name = local.ResourceGroup
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "sqladmin"
  admin_password      = "Wipro@123456789"
  network_interface_ids = [
    azurerm_network_interface.VMNIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
*/
## Databse
resource "azurerm_mssql_server" "sqlsrv20241107" {
  name                         = "sqlsrv20241108"
  resource_group_name          = local.ResourceGroup
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "vishal"
  administrator_login_password = "Wipro@1234567890"

  depends_on = [ azurerm_resource_group.myRG ]
}

resource "azurerm_mssql_database" "testsqldb" {
  name         = "testsqldb"
  server_id    = azurerm_mssql_server.sqlsrv20241107.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
  depends_on = [ azurerm_mssql_server.sqlsrv20241107 ]
  }

