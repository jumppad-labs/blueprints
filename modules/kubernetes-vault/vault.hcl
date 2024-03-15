resource "template" "helm_values" {
  source = <<-EOF
   ---
   server:
     dataStorage:
       size: 128Mb
     dev:
       enabled: true
     standalone:
       enabled: true
     authDelegator:
       enabled: true
   ui:
     enabled: true
  EOF

  destination = "${data("helm-values")}/default-values.yaml"
}


resource "helm" "vault" {
  // adding a manual depends on rather than the interpolated 
  // resouce.template.helm_values.destination
  // as the user can override the helm values
  depends_on = ["resource.template.helm_values"]

  cluster   = variable.k8s_cluster
  namespace = variable.namespace

  repository {
    name = "hashicorp"
    url  = "https://helm.releases.hashicorp.com"
  }

  chart   = "hashicorp/vault"
  version = variable.helm_version

  values = variable.helm_values

  health_check {
    timeout = "120s"
    pods    = ["app.kubernetes.io/name=vault", "app.kubernetes.io/name=vault-agent-injector"]
  }
}

resource "ingress" "vault_http" {
  port = variable.api_port

  target {
    resource = variable.k8s_cluster
    port     = 8200

    config = {
      service   = "vault-ui"
      namespace = variable.namespace
    }
  }
}

output "vault_addr" {
  value = "http://${resource.ingress.vault_http.local_address}"
}

output "vault_token" {
  value = "root"
}