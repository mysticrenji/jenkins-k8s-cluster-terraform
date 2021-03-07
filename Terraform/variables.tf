variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "rg-experiments-terraform"
}

variable "az-backend" {
  description = "Backend for terraform in Azure"
  default     = "terraformblobstoragedev"
}

variable "location" {
  description = "Location of the resources"
  default     = "Southeast Asia"
}


variable "dns" {
  description = "DNS Prefix"
  default     = "garage"
}


variable "clustername" {
  description = "clustername for aks"
  default     = "aks-garage-terraform"
}
