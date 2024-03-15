resource "network" "local" {
  subnet = "10.5.0.0/16"
}

resource "k8s_cluster" "k3s" {
  network {
    id = resource.network.local.meta.id
  }
}

module "vault" {
  source = "github.com/jumppad-labs/examples?ref=6ce208995de36d85df5357a9762eb3854be2b434/modules/kubernetes-vault"
  //source = "../modules/kubernetes-vault"

  variables = {
    namespace    = "default"
    helm_version = "0.24.0"
    api_port     = 8200
    k8s_cluster  = resource.k8s_cluster.k3s
  }
}

output "KUBECONFIG" {
  value = resource.k8s_cluster.k3s.kube_config.path
}

output "VAULT_ADDR" {
  value = module.vault.output.vault_addr
}

output "VAULT_TOKEN" {
  value = module.vault.output.vault_token
}