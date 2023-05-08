resource "template" "agent_config" {
  source = <<-EOF
    datacenter = "dc1"
    retry_join = ["${variable.consul_server}"]
  EOF

  destination = "${data("nomad")}/consul.hcl"
}

resource "nomad_cluster" "dev" {
  client_nodes = variable.client_nodes

  consul_config = resource.template.agent_config.destination

  network {
    id = variable.network
  }
}

resource "nomad_job" "api" {
  cluster = resource.nomad_cluster.dev.id

  paths = ["./jobs/api.hcl"]
}
