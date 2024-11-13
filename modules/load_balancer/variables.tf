variable "name_prefix" {
  description = "Prefix for naming resources uniformly across environments"
  type        = string
}

variable "location" {
  description = "Azure location where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

variable "ip_sku" {
  description = "Type of public IP allocated"
  type        = string
  default     = "Standard"
}

variable "frontend_port" {
  description = "The frontend port on which the Load Balancer will listen"
  type        = number
}

variable "backend_port" {
  description = "The backend port to which the Load Balancer will forward traffic"
  type        = number
}

variable "health_probe_port" {
  description = "The port for the health probe to monitor on backend instances"
  type        = number
}

variable "health_probe_request_path" {
  description = "The request path for the health probe"
  type        = string
}
