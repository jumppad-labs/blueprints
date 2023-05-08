resource "template" "server_config" {
  source = <<-EOF
    data_dir = "/tmp/"
    log_level = "DEBUG"
    
    datacenter = "dc1"
    primary_datacenter = "dc1"

    retry_join = ["server-1.consul.container.jumppad.dev", "server-2.consul.container.jumppad.dev", "server-3.consul.container.jumppad.dev"]
    
    server = true
    
    bootstrap_expect = ${variable.consul_nodes}
    ui = true
    
    bind_addr = "0.0.0.0"
    client_addr = "0.0.0.0"
    
    ports {
      grpc = 8502
    }
    
    connect {
      enabled = true
    }
  EOF

  destination = "${data("consul")}/server.hcl"
}


resource "container" "server-1" {
  image {
    name = variable.consul_version
  }

  command = ["consul", "agent", "-config-file=/config/config.hcl"]

  volume {
    source      = resource.template.server_config.destination
    destination = "/config/config.hcl"
  }

  network {
    id = variable.network
  }

  port {
    local  = 8500
    remote = 8500
    host   = variable.consul_port
  }
}

resource "container" "server-2" {
  disabled = variable.consul_nodes < 2

  image {
    name = variable.consul_version
  }

  command = ["consul", "agent", "-config-file=/config/config.hcl"]

  volume {
    source      = resource.template.server_config.destination
    destination = "/config/config.hcl"
  }

  network {
    id = variable.network
  }
}

resource "container" "server-3" {
  disabled = variable.consul_nodes < 3

  image {
    name = variable.consul_version
  }

  command = ["consul", "agent", "-config-file=/config/config.hcl"]

  volume {
    source      = resource.template.server_config.destination
    destination = "/config/config.hcl"
  }

  network {
    id = variable.network
  }
}