terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
  required_version = ">=1.1.0"
}



provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "resource_group" {
  source          = "../../modules/resource-group"
  name            = var.resource_group_name
  location        = var.resource_group_location
  subscription_id = var.subscription_id
}

module "acr" {
  source              = "../../modules/acr"
  name                = var.acr_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled
  subscription_id     = var.subscription_id
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = module.aks.kubelet_identity_object_id
  role_definition_name = "AcrPull"
  scope                = module.acr.acr_id
}

module "aks" {
  source              = "../../modules/aks"
  dns_prefix          = "fiapakshack"
  cluster_name        = "fiapaks"
  cluster_location    = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  tags                = { "env" = "dev" }
  subscription_id     = var.subscription_id
  node_count          = 1
  vm_size             = "Standard_D2as_v6"
}



provider "kubernetes" {
  # config_path = "~/.kube/config" # Caminho para o arquivo kubeconfig
  host                   = module.aks.aks_host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.aks_client_key)
  cluster_ca_certificate = base64decode(module.aks.aks_ca_certificate)
}

resource "kubernetes_namespace" "hk" {
  metadata {
    name = var.kube_namespace
  }
  depends_on = [module.aks]
}

module "storage" {
  source                   = "../../modules/azure_storage"
  storage_account_name     = "fiaphkstorage"
  resource_group_name      = var.resource_group_name
  resource_group_location  = var.resource_group_location
  account_tier             = "Standard"
  access_tier              = "Cool"
  account_replication_type = "LRS"
  storage_share_name       = var.storage_share_name
  storage_share_quota      = 10
  depends_on               = [module.resource_group]
}

module "sql_server_config_map" {
  source    = "../../modules/configmap"
  name      = "sql-server-config-map"
  namespace = var.kube_namespace
  data = {
    ACCEPT_EULA = "Y"
  }
}

module "sql_server_secret" {
  source            = "../../modules/secrets"
  name              = "sql-server-secret"
  namespace         = var.kube_namespace
  mssql_sa_password = var.mssql_sa_password
  svc_pass          = var.svc_pass
}

resource "kubernetes_secret" "sql_connection_string" {
  metadata {
    name      = "db-connection"
    namespace = var.kube_namespace
  }

  data = {
    ConnectionStrings__DefaultConnection     = var.db_connection
    ConnectionStrings__DatabaseDllConnection = var.db_connection
  }
}

resource "kubernetes_secret" "sql_connection_string_user" {
  metadata {
    name      = "db-connection-user"
    namespace = var.kube_namespace
  }

  data = {
    ConnectionStrings__DefaultConnection     = var.db_connection_user
    ConnectionStrings__DatabaseDllConnection = var.db_connection_user
  }
}