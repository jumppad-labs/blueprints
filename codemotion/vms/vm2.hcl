resource "container" "vm2" {
  network {
    id = variable.network
  }

  image {
    name = "nicholasjackson/vm:0.1.0"
  }

  volume {
    source      = "./files/supervisor.conf"
    destination = "/etc/supervisor/conf.d/ssh.conf"
  }

  volume {
    source      = data("temp")
    destination = "/init"
  }

  volume {
    source      = resource.template.consul_config_2.destination
    destination = "/config/service.hcl"
  }

  environment = {
    NAME              = "API - vm2"
    MESSAGE           = "Hi I am running in a Virtual Machine"
    CONSUL_DATACENTER = "dc1"
    CONSUL_SERVER     = variable.consul_server
  }
}

resource "template" "consul_config_2" {
  source = <<-EOF
    service {
      id = "api-vm2"
      name = "api"
      port = 9090
    }
  EOF

  destination = "${data("consul_config")}/service2.hcl"
}