provider "kubernetes" {
    config_path = "~/.kube/config"
    config_context = "minikube"
}


# Define the Helm provider
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "minikube"
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Define the Prometheus chart
resource "helm_release" "prometheus" {
  name      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart     = "prometheus"
  namespace = kubernetes_namespace.monitoring.metadata[0].name

  set {
    name = "server.persistentVolume.enabled"
    value = true
  }
  
  set {
    name = "server.persistentVolume.size"
    value = "5Gi"
  }
  
  set {
    name = "alertmanager.persistentVolume.enabled"
    value = true
  }
  
  set {
    name = "alertmanager.persistentVolume.size"
    value = "2Gi"
  }
}

resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"

  set {
    name  = "server.dev.enabled"
    value = true
  }

  set {
    name  = "server.dev.ha"
    value = true
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

resource "helm_release" "jaeger" {
  name = "jaeger"
  repository = "https://jaegertracing.github.io/helm-charts"
  chart = "jaeger"

  set {
    name = "provisionDataStore.cassandra"
    value = false
  }

  set {
    name = "allInOne.enabled"
    value = true
  }

  set {
    name = "storage.type"
    value = "none"
  }

  set {
    name = "agent.enabled"
    value = false
  }

  set {
    name = "collector.enabled"
    value = false
  }

  set {
    name = "query.enabled"
    value = false
  }
}