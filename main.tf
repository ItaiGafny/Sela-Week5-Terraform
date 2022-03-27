# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate519772350"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "state-week5-secure" {
  name     = "state-week5"
  location = "eastus"
}

# Confgiure the resource group for the project
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}rg"
  location = var.location
  tags = {
    Environment = "${var.prefix}"
  }
}

# Prefix name for all resources in resource group
variable "prefix" {
  type = string
}

# Default location for all resources
variable "location" {
  type = string
}

# Number of virtuall machines in the HA zone
variable "instance_count" {
  type    = number
}

# Default VM size
variable "vm_size" {
  type = string
}


module "vms" {
  source         = "./modules/vms"
  prefix         = var.prefix
  rg-name        = local.rg-name
  location       = var.location
  instance_count = var.instance_count
  vm_size        = var.vm_size
  DataTierNSG_id = azurerm_network_security_group.DataTierNSG.id
  WebTierNSG_id  = azurerm_network_security_group.WebTierNSG.id
}

locals {
  location = var.location
  prefix   = var.prefix
  rg-name  = azurerm_resource_group.rg.name
}

