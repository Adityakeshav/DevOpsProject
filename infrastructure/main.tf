provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "devops_rg" {
  name     = "devops-project-rg"
  location = "Central India"
}

resource "azurerm_container_group" "devops_aci" {
  name                = "devops-project-aci"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "devops-flask-app"
    image  = var.docker_image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}