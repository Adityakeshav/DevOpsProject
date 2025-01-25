variable "docker_image" {
  description = "Docker image for the DevOps project Flask app"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID for the DevOps project"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Azure client ID for the DevOps project"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure client secret for the DevOps project"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID for the DevOps project"
  type        = string
  sensitive   = true
}