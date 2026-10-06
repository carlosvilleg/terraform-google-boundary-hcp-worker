variable "prefix" {
	type = string
	default = "boundary-egress"
}

variable "vpc" {
	type = string
}

variable "vpc_project_id" {
	type = string
	description = "ID of GCP Project where the existing VPC resides if it is different than the default project."
	default = null
}

variable "subnet_name" {
	type = string
}

variable "hcp_boundary_cluster_id" {
	type = string
}


variable "project_id" {}

variable "region" {}

variable "enable_iap" {}

variable "image_name" {
	type = string
}

variable "image_project_id" {
	type = string
	default = null
}

# Vault Configuration
variable "vault_url" {
	type = string
}

variable "vault_namespace" {
	type = string
}

variable "vault_gcp_auth_path" {
	type = string
  default = "gcp"
}

variable "vault_auth_role_name" {
	type = string
  default = "boundary-worker-role"
}

variable "vault_secret_path" {
	type = string
  default = "secret/data/boundary/worker"
}

variable "boundary_auth_method_id" {
	type = string
}

variable "disable_vault_integration" {
	type = bool
  default = false
  description = "If set to true, disables the integration with Vault, and the boundary username and password must be provided"
}

variable "boundary_username" {
  type = string
  default = ""
  validation {
    condition     = (var.disable_vault_integration && var.boundary_username != "") || (!var.disable_vault_integration && var.boundary_username == "")
    error_message = "Boundary username must be specified if the Vault integration is disabled, a boundary_password will also need to be provided"
  }
}

variable "boundary_password" {
	type = string
  default = ""
  validation {
    condition     = (var.disable_vault_integration && (var.boundary_username != "" && var.boundary_password != "")) || (!var.disable_vault_integration && var.boundary_username == "" && var.boundary_password == "")
    error_message = "Boundary password must be specified if the Vault integration is disabled and a boundary_username must also be provided"
    }
}

variable "boundary_dir_home" {
  type = string
  default = "/opt/boundary"
}


