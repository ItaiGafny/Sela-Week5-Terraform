resource "azurerm_network_security_group" "WebTierNSG" {
  name                = "${var.prefix}WebTierNSG"
  location            = local.location
  resource_group_name = local.rg-name

  security_rule {
    name                       = "Port_8080"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "DataTierNSG" {
  name                = "${var.prefix}DataTierNSG"
  location            = local.location
  resource_group_name = local.rg-name

  security_rule {
    name                       = "Port_5432"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "10.0.0.4"
    destination_address_prefix = "*"
  }
}

#Bastion - secure connection to our network

resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.rg-name
  virtual_network_name = module.vms.vnet-name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "bastion-ip" {
  name                = "${var.prefix}bastion-ip"
  location            = local.location
  resource_group_name = local.rg-name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.prefix}bastion"
  location            = local.location
  resource_group_name = local.rg-name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-ip.id
  }
}