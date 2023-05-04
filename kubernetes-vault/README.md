# Kubernetes Vault

Jumppad example which uses the kubernetes-vault module to install Vault
on a Kubernetes cluster.

```
jp up .
```

```
Running configuration from:  .

2023-05-04T09:26:19.659+0100 [INFO]  Parsing configuration: path=/home/nicj/go/src/github.com/jumppad-labs/blueprints/kubernetes-vault
2023-05-04T09:26:19.663+0100 [INFO]  Creating resources from configuration: path=/home/nicj/go/src/github.com/jumppad-labs/blueprints/kubernetes-vault
2023-05-04T09:26:19.663+0100 [INFO]  Creating ImageCache: ref=default
2023-05-04T09:26:23.250+0100 [INFO]  Creating Network: ref=resource.network.local
2023-05-04T09:26:23.282+0100 [INFO]  Creating ImageCache: ref=default
2023-05-04T09:26:24.050+0100 [INFO]  k3s: Creating Cluster: ref=resource.k8s_cluster.k3s
2023-05-04T09:26:26.805+0100 [INFO]  k3s: network: net="{resource.network.local  [] local 10.5.0.3/16}"
2023-05-04T09:26:34.664+0100 [INFO]  Please wait, still creating resources [Elapsed Time: 15.001332]
2023-05-04T09:26:49.663+0100 [INFO]  Please wait, still creating resources [Elapsed Time: 30.000142]
2023-05-04T09:26:50.788+0100 [INFO]  Creating Module: ref=vault
2023-05-04T09:26:50.788+0100 [INFO]  Generating template: ref=module.vault.resource.template.helm_values output=/home/nicj/.jumppad/data/helm-values/default-values.yaml
2023-05-04T09:26:50.788+0100 [INFO]  Creating Output: ref="KUBECONFIG"
2023-05-04T09:26:50.788+0100 [INFO]  Creating Helm chart: ref=module.vault.resource.helm.vault
2023-05-04T09:27:04.663+0100 [INFO]  Please wait, still creating resources [Elapsed Time: 45.000975]
2023-05-04T09:27:05.264+0100 [INFO]  Creating Output: ref=vault_token
2023-05-04T09:27:05.264+0100 [INFO]  Creating Output: ref="VAULT_TOKEN"
2023-05-04T09:27:05.264+0100 [INFO]  Create Ingress: ref=module.vault.resource.ingress.vault_http
2023-05-04T09:27:05.294+0100 [INFO]  Creating Output: ref=vault_addr
2023-05-04T09:27:05.294+0100 [INFO]  Creating Output: ref="VAULT_ADDR"
```