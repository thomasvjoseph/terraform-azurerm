resource "azurerm_public_ip" "appgw_public_ip" {
  name                = "example-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "example-appgateway"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    #capacity =
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "httpPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendConfig"
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

  backend_address_pool {
    name  = "backendPool"
    fqdns = var.fqdns
  }

  probe {
    name                                      = "myprobe"
    protocol                                  = "Http"
    path                                      = "/health"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

    match {
      status_code = ["200-399"]
    }
  }

  backend_http_settings {
    name                                = "backendHttpSettings"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 120
    pick_host_name_from_backend_address = true
    probe_name                          = "myprobe"
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendConfig"
    frontend_port_name             = "httpPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "httpRoutingRule"
    priority                   = 1
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "backendPool"
    backend_http_settings_name = "backendHttpSettings"
  }
  autoscale_configuration {
    min_capacity = 1
    max_capacity = 10
  }
  tags       = var.tags
  depends_on = [azurerm_public_ip.appgw_public_ip]
}