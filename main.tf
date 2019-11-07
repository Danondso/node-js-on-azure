# Infrastructure as code oh boy!
# Configure the Azure Provider

# then reference the tfvars variable here
# variable "variable_name" {} -> But this seems like being extra verbose

provider "azurerm" {
  version         = "1.36.0"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
}

# Create a resource group
resource "azurerm_resource_group" "a-task-called-quest" {
  name     = "${var.web_server_rg}"
  location = "${var.web_server_location}"
}

resource "azurerm_virtual_network" "web_server_vnet" {
  name                = "${var.resource_prefix}-vnet"
  location            = "${var.web_server_location}"
  resource_group_name = "${azurerm_resource_group.a-task-called-quest.name}"
  address_space       = ["${var.web_server_address_space}"]
}

#child resource so terraform doesn't need a location
resource "azurerm_subnet" "web_server_subnet" {
  name                 = "${var.resource_prefix}-subnet"
  resource_group_name  = "${azurerm_resource_group.a-task-called-quest.name}"
  virtual_network_name = "${azurerm_virtual_network.web_server_vnet.name}"
  address_prefix       = "${var.web_server_address_prefix}"
}

resource "azurerm_network_interface" "web_server_nic" {
  name                = "${var.web_server_name}-nic"
  location            = "${var.web_server_location}"
  resource_group_name = "${azurerm_resource_group.a-task-called-quest.name}"

  ip_configuration {
    name                          = "${var.web_server_name}-ip"
    subnet_id                     = "${azurerm_subnet.web_server_subnet.id}" #uses resource id over name
    private_ip_address_allocation = "dynamic"
  }
}