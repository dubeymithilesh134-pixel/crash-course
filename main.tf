terraform {
  
  required_providers {

    azurerm = {

      source = "hashicorp/azurerm"
      version = "5.11.0"
    } 
  }
}

provider "azurerm" {

  features {
    
  }
  
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tfe-practice-dev"
  location = "Central India"

  tags = {
    environment = "dev"
    managed_by  = "terraform-enterprise"
    owner       = "mithlesh"
  }
}

# 4. Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-tfe-dev-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "dev"
    managed_by  = "terraform-enterprise"
  }
}

# 5. Subnet inside VNet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-app-dev-01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
