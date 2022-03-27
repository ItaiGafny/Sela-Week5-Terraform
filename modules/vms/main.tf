#virtual machines from image

# Predefined web server image with update app
data "azurerm_resource_group" "image" {
  name = "vm-templates-rg"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}${count.index}"
  count               = var.instance_count
  location            = var.location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.public-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
# Create a new Virtual Machine based on webserver image
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}webserver-${count.index}"
  count                 = var.instance_count
  location              = var.location
  resource_group_name   = var.rg-name
  network_interface_ids = [azurerm_network_interface.main[count.index].id]
  vm_size               = var.vm_size
  #vm_size                          = "Standard_B2ms"
  availability_set_id              = azurerm_availability_set.aset.id
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = "/subscriptions/e8657681-5f64-4bab-81cf-237a597fcd11/resourceGroups/vm-templates-rg/providers/Microsoft.Compute/galleries/vm_gallery/images/webserver-image-definition"
  }

  storage_os_disk {
    name              = "${var.prefix}webserver-${count.index}-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

}