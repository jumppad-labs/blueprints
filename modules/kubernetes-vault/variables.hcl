variable "namespace" {
  default     = "default"
  description = <<EOF
    The Kubernetes namespace to install the chart to
  EOF
}

variable "helm_values" {
  default     = "${data("helm-values")}/default-values.yaml"
  description = <<EOF
    Path to a file containing Helm values to use when applying the Helm
    chart to Kubernetes.
  EOF
}

variable "helm_version" {
  default     = "0.24.0"
  description = <<EOF
    Version of the Helm chart to apply
  EOF
}

variable "api_port" {
  default     = 8200
  description = <<EOF
    Port to expose the Vault server on locally
  EOF
}


variable "k8s_cluster" {
  default     = ""
  description = <<EOF
    Kuberentes cluster to use to install Vault. This value should
    be the `k8s_cluster` resource. i.e. `resource.k8s_cluster.dev`.
  EOF
}