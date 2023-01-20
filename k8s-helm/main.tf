terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}

resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "helm_release" "redis" {
  name = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"

  set {
    name = "service.type"
    value = ""
  }
}