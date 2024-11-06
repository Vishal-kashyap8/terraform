/*Network Security group creation*/

resource "azurerm_network_security_group" "NSG1" {
    name = "nsg1"
    resource_group_name = "myGroup"
    location = "North Europe"
    depends_on = [ azurerm_resource_group.myRG ]
}

/*Network Security group Rule defination*/
resource "azurerm_network_security_rule" "Rule1" {
    name = "rule1"
    priority = 100
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = "myGroup"
    network_security_group_name  = "nsg1" 
}


resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet"
  address_space       = ["10.5.0.0/16"]
  location            = local.location
  resource_group_name = local.ResourceGroup
  depends_on = [azurerm_resource_group.myRG]
}

resource "azurerm_subnet" "Prod" {
  name                 = "prod"
  resource_group_name  = local.ResourceGroup  
  virtual_network_name = "myvnet"
  address_prefixes     = ["10.5.2.0/24"]
  depends_on = [ azurerm_virtual_network.myvnet ]
}

resource "azurerm_network_interface" "VMNIC" {
  name                = "VMNIC-nic"
  location            = local.location
  resource_group_name = local.ResourceGroup

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Prod.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ azurerm_subnet.Prod ]
}