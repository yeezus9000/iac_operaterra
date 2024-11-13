output "load_balancer_id" {
  description = "ID of the Load Balancer"
  value       = azurerm_lb.load_balancer.id
}

output "load_balancer_ip" {
  description = "Public IP address of the Load Balancer"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

output "backend_pool_id" {
  description = "ID of the Load Balancer Backend Pool"
  value       = azurerm_lb_backend_address_pool.backend_pool.id
}
