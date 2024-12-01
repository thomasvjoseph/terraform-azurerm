resource "azurerm_resource_group" "resource_group" {
  location = var.resource_group_location
  name     = var.resource_group_name_prefix

  tags = {
    environment = "Dev"
    Service     = "Resource Group"
  }
}

module "virtual_network" {
  source = "../Modules/VirtualNetwork"
  #version              = "1.1.2"
  virtual_network_name = "example-network"
  location             = azurerm_resource_group.resource_group.location
  resource_group_name  = azurerm_resource_group.resource_group.name
  subnets = {
    subnet1 = {
      name                                          = "subnet1-postgres"
      address_prefix                                = ["10.0.1.0/24"]
      is_private                                    = true
      private_endpoint_network_policies             = "Disabled"
      private_link_service_network_policies_enabled = "true"
    }
    subnet2 = {
      name                                          = "subnet2-redis-cache"
      address_prefix                                = ["10.0.2.0/24"]
      is_private                                    = true
      private_endpoint_network_policies             = "Disabled"
      private_link_service_network_policies_enabled = "true"
    }
    subnet3 = {
      name                                          = "subnet3-container-app"
      address_prefix                                = ["10.0.3.0/24"]
      is_private                                    = false
      private_endpoint_network_policies             = "Enabled" # Changed to Enabled
      private_link_service_network_policies_enabled = "true"    # Changed to true
    }
    subnet4 = {
      name                                          = "subnet4-application-gateway"
      address_prefix                                = ["10.0.4.0/24"]
      is_private                                    = false
      private_endpoint_network_policies             = "Enabled" # Changed to Enabled
      private_link_service_network_policies_enabled = "true"    # Changed to true
    }
  }
  subnet_service_endpoints = {
    subnet1-postgres            = ["Microsoft.Storage"]
    subnet3-container-app       = ["Microsoft.KeyVault"]
    subnet4-application-gateway = ["Microsoft.KeyVault"]
  }
  subnet_delegation = {
    subnet1-postgres = [{
      name = "subnet_delegation_postgres"
      service_delegation = {
        name    = "Microsoft.DBforPostgreSQL/flexibleServers"
        actions = []
      }
    }]
    subnet3-container-app = [{
      name = "subnet_delegation_container_app"
      service_delegation = {
        name    = "Microsoft.App/environments"
        actions = []
      }
    }]
  }
  depends_on = [azurerm_resource_group.resource_group]
}

module "log_analytics_workspace" {
  source                       = "../Modules/Workspace"
  location                     = azurerm_resource_group.resource_group.location
  resource_group_name          = azurerm_resource_group.resource_group.name
  log_analytics_workspace_name = "example-log"
  log_sku                      = "PerGB2018"
  log_retention_days           = 30
  depends_on                   = [azurerm_resource_group.resource_group]
}

module "container_app" {
  source                     = "../Modules/ContainerApps"
  location                   = azurerm_resource_group.resource_group.location
  resource_group_name        = azurerm_resource_group.resource_group.name
  c_app_env_name             = "test123"
  log_analytics_workspace_id = module.log_analytics_workspace.log_analytics_workspace_id
  subnet_id                  = module.virtual_network.public_subnet_id["subnet3"]
  app_gateway_subnet_cidr    = module.virtual_network.subnet_cidr["subnet4-application-gateway"][0]
  container_app_name         = "example-app"
  depends_on                 = [module.log_analytics_workspace, module.virtual_network]
}

module "ApplicationGateway" {
  source              = "../Modules/AGW"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  subnet_id           = module.virtual_network.public_subnet_id["subnet4"]
  fqdns               = [module.container_app.container_app_fqdn]
  depends_on          = [azurerm_resource_group.resource_group, module.virtual_network, module.container_app]
}

module "SecurityGroup" {
  source              = "./Modules/SecurityGroup"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  network_security_groups = {
    app_gateway_nsg = {
      name = "app-gateway-nsg"
      tags = {}
      subnet_ids = [module.VirtualNetwork.public_subnet_id["subnet4"]]
      security_rules = [
        {
          name                       = "Allow-HTTP-Inbound"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow-AzureLoadBalancer"
          priority                   = 120
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "AzureLoadBalancer"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow-Application-Gateway"
          priority                   = 130
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "65200-65535"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow-To-ContainerApps"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "10.0.4.0/24"
          destination_address_prefix = "10.0.3.0/24"
        },
        {
          name                       = "Allow-Internet-Outbound"
          priority                   = 110
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "Internet"
        },
        {
          name                       = "Allow-All-Outbound"
          priority                   = 140
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  }
  depends_on = [azurerm_resource_group.resource_group, module.VirtualNetwork]
}