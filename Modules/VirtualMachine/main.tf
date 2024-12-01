resource "azurerm_network_interface" "vm_nic" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm_instance" {
  name                  = "example-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = "Standard_B1ls"

  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "azureuser"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = var.ssh_keys
    }
  }

  tags = {
    Environment = "Dev"
    Service     = "Virtual Machine"
  }
}

resource "azurerm_network_interface_security_group_association" "vm_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = var.nsg_id
}