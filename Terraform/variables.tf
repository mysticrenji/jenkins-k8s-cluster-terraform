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

variable "prefix" {
  description = "A prefix used for all resources in this example"
  default     = "terraform-garage"
}

# variable "client_app_id" {
#   description = "The Client app ID of the AKS client application"
# }

# variable "server_app_id" {
#   description = "The Server app ID of  the AKS server application"
# }

# variable "server_app_secret" {
#   description = "The secret created for AKS server application"
# }

# variable "tenant_id" {
#   description = "The Azure AD tenant id "
# }
