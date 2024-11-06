
locals {
  location= "North Europe"
  ResourceGroup= "myGroup"
}

resource "azurerm_resource_group" "myRG" {
  name = "myGroup"
  location = "North Europe"
}

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
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}