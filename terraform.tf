terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.9.0, <= 2.0.0"
    }
  }
}
