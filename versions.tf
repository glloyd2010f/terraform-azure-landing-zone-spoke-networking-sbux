terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "~> 3.101.0"
    }
  }
}