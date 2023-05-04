# Jumppad module to install HashiCorp Vault on Kubernetes

This module installs HashiCorp Vault on Kubernetes

## Example

The following example shows a simple use of this module.

```javascript
resource "network" "local" {
  subnet = "10.5.0.0/16"
}

resource "k8s_cluster" "k3s" {
  driver = "k3s" // default

  nodes = 1 // default

  network {
    id = resource.network.local.id
  }
}

module "vault" {
  source = "github.com/jumppad-labs/blueprints/modules//vault"

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
```

## Variables

The following variables can be used to configure this module.

### namespace

The namespace to install the Helm chart to.

#### default: 'default' 


### helm_values

Path to a file containing the Helm values to use when applying the helm chart.

#### default: '${data("helm-values")}/default-values.yaml'


### helm_version

Version of the Helm chart to install.

#### default: 'v0.24.0'


### api_port

The port to expose the Vault server locally.

#### default: 8200


### k8s_cluster_id

The cluster id of the Kubernetes cluster resource where the helm chart will
be applied.

#### default: ''


## Outputs

The following outputs are exposed by this module.

### vault_addr

The fully qualified address and port where the Vault server can be reached.

### vault_token

The fully token that can be used to access the Vault server.