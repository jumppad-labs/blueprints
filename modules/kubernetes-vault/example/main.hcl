resource "network" "local" {
  subnet = "10.5.0.0/16"
}

resource "k8s_cluster" "k3s" {
  network {
    id = resource.network.local.id
  }
}

module "vault" {
  source = "../"

  variables = {
    namespace      = "default"
    helm_version   = "0.24.0"
    api_port       = 8200
    k8s_cluster_id = resource.k8s_cluster.k3s.id
  }
}

output "KUBECONFIG" {
  value = resource.k8s_cluster.k3s.kubeconfig
}

output "VAULT_ADDR" {
  value = module.vault.output.vault_addr
}

output "VAULT_TOKEN" {
  value = module.vault.output.vault_token
}