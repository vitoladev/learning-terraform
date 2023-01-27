terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
}

# Define the Helm provider
provider "helm" {
  kubernetes {
    config_path = "${var.kubeconfig_path}"
    config_context = "minikube"
  }
}

resource "kubernetes_namespace" "sonarqube" {
  metadata {
    name = "sonarqube"
  }
}

# Define the Prometheus chart
resource "helm_release" "prometheus" {
  name      = "prometheus"
  chart     = "stable/prometheus"
  namespace = "monitoring"

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