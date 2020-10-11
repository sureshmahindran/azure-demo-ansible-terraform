# Create a new Virtual Machine based on the Custom Image
resource "azurerm_virtual_machine" "rmqcvm3" {
  name                  = "rabbitmq-node3"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic3.id]
  vm_size               = "Standard_B1ms"

  # Zone info

  #  zones = [1]

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "disk-node3"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "node03"
    admin_username = "azureadmin"


  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/azureadmin/.ssh/authorized_keys"
    }
  }

}


