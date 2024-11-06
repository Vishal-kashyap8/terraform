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
    depends_on = [ azurerm_resource_group.myRG ]
}