variable "namespace" {
  default = "ingress"
}

# Define the Helm release for the Ingress Controller
resource "helm_release" "ingress_controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.namespace

  # Define the values for the Helm chart
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}