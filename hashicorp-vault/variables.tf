variable "kubeconfig_path" {
  type = "string"
  description = "The path to your local kubeconfig"
  default = "~.kube/config"
}