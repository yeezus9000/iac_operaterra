# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.name_prefix}-lb-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = var.ip_sku
}

# Load Balancer Resource
resource "azurerm_lb" "load_balancer" {
  name                = "${var.name_prefix}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard" # Can be set to "Basic" for lower environments

  frontend_ip_configuration {
    name                 = "PublicIPConfig"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name = "${var.name_prefix}-backend-pool"
  # resource_group_name = var.resource_group_name
  loadbalancer_id = azurerm_lb.load_balancer.id
}

# Load Balancer Rule for HTTP Traffic
resource "azurerm_lb_rule" "http_rule" {
  name = "HTTPRule"
  # resource_group_name             = var.resource_group_name
  loadbalancer_id                = azurerm_lb.load_balancer.id
  protocol                       = "Tcp"
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = "PublicIPConfig"
  # backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
  probe_id = azurerm_lb_probe.http_probe.id
}

# Health Probe for Load Balancer
resource "azurerm_lb_probe" "http_probe" {
  name = "HTTPHealthProbe"
  # resource_group_name = var.resource_group_name
  loadbalancer_id = azurerm_lb.load_balancer.id
  protocol        = "Http"
  port            = var.health_probe_port
  request_path    = var.health_probe_request_path
}
