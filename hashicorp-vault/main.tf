provider "helm" {
  kubernetes {
    config_path = "${var.kubeconfig_path}"
  }
}

resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"

  set {
    name  = "server.dev.enabled"
    value = "true"
  }

  set {
    name  = "server.dev.ha"
    value = "true"
  }

  set {
    name  = "server.dev.storage.path"
    value = "/vault/data"
  }

  set {
    name  = "server.dev.storage.size"
    value = "5Gi"
  }

  set {
    name  = "server.dev.config.listener.tcp.address"
    value = "0.0.0.0:8200"
  }
}