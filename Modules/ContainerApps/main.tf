resource "azurerm_container_app_environment" "container_app_environment" {
  name                           = var.c_app_env_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  infrastructure_subnet_id       = var.subnet_id
  internal_load_balancer_enabled = false
  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
    minimum_count         = 1
    maximum_count         = 10
  }
}

resource "azurerm_container_app" "container_app" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"

      readiness_probe {
        interval_seconds        = 10
        failure_count_threshold = 3
        transport               = "HTTP"
        port                    = 80
        path                    = "/health"
      }
      env {
        name  = "exampleEnv"
        value = "80"
      }
    }
    min_replicas = 1
    max_replicas = 5
    http_scale_rule {
      name                = "example-rule"
      concurrent_requests = 10
    }
  }
  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    ip_security_restriction {
      name             = "AllowAppGatewayOnly"
      action           = "Allow"
      ip_address_range = var.app_gateway_subnet_cidr
      description      = "Allow only App Gateway subnet"
    }

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}