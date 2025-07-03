resource "azurerm_network_interface_security_group_association" "grafana" {
  network_interface_id      = azurerm_network_interface.grafana.id
  network_security_group_id = azurerm_network_security_group.main.id
}
resource "azurerm_network_security_group" "main" {
  security_rule {
    name                       = "Prometheus"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9090"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "NodeExporter"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9100"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  name                = "projet-python-nsg"
  location            = "westeurope"
  resource_group_name = "projet-python-rg"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Grafana"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Flask"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}
provider "azurerm" {
  features {}
}


resource "azurerm_virtual_network" "main" {
  name                = "projet-python-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  resource_group_name = "projet-python-rg"
}

resource "azurerm_subnet" "main" {
  name                 = "projet-python-subnet"
  resource_group_name  = "projet-python-rg"
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "projet-python-nic"
  location            = "westeurope"
  resource_group_name = "projet-python-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_public_ip" "main" {
  name                = "projet-python-public-ip"
  location            = "westeurope"
  resource_group_name = "projet-python-rg"
  allocation_method   = "Static"
}


# VM principale pour l'app Flask (plus grosse taille)
resource "azurerm_linux_virtual_machine" "app" {
  name                = "projet-python-app-vm"
  resource_group_name = "projet-python-rg"
  location            = "westeurope"
  size                = "Standard_B2ms" # 2 vCPU, 8 Go RAM
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/../deploy_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# VM dédiée à Grafana
resource "azurerm_public_ip" "grafana" {
  name                = "projet-grafana-public-ip"
  location            = "westeurope"
  resource_group_name = "projet-python-rg"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "grafana" {
  name                = "projet-grafana-nic"
  location            = "westeurope"
  resource_group_name = "projet-python-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.grafana.id
  }
}

resource "azurerm_linux_virtual_machine" "grafana" {
  name                = "projet-grafana-vm"
  resource_group_name = "projet-python-rg"
  location            = "westeurope"
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.grafana.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/../deploy_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

output "app_public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}

output "grafana_public_ip_address" {
  value = azurerm_public_ip.grafana.ip_address
}

output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}
