variable "resource_group_name" {
  default = "fiap-hackathon"
}
variable "resource_group_location" {
  default = "eastus"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "fiapacrhackathon"
}

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "acr_admin_enabled" {
  description = "Enable admin user for the Azure Container Registry"
  type        = bool
  default     = false
}

variable "subscription_id" {
  description = "Azure subscription id"
  type        = string
  default     = "7d56ed09-a476-4593-9fbf-0927c0c53f5e"
}

variable "kube_namespace" {
  type        = string
  default     = "hk"
  description = "Kubernetes configmap namespace"
}

//Secret
variable "mssql_sa_password" {
  description = "sql server sa password"
  type        = string
  sensitive   = true
}

variable "svc_pass" {
  description = "service user password"
  type        = string
  sensitive   = true
}

variable "db_connection" {
  description = "Sql Server Connection String - encrypted"
  type        = string
  sensitive   = true
}

variable "storage_account_name" {
  description = "Azure storage accout name."
  type        = string
  default     = "fiaphkstorage"
}

variable "storage_share_name" {
  type    = string
  default = "sql-server-fileshare"
}
