resource "certificate_ca" "ssh_key" {
  output = data("ssh_key")
}

resource "random_number" "port" {
  minimum = 10000
  maximum = 20000
}

resource "container" "vm1" {
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
    source      = resource.template.consul_config_1.destination
    destination = "/config/service.hcl"
  }

  ## Public SSH
  port {
    host   = resource.random_number.port.value
    local  = 22
    remote = 22
  }

  environment = {
    NAME              = "API - vm1"
    MESSAGE           = "Hi I am running in a Virtual Machine"
    CONSUL_DATACENTER = "dc1"
    CONSUL_SERVER     = variable.consul_server
  }
}


resource "template" "consul_config_1" {
  source = <<-EOF
    service {
      id = "api-vm1"
      name = "api"
      port = 9090
    }
  EOF

  destination = "${data("consul_config")}/service1.hcl"
}

resource "template" "vm_init" {
  source = <<-EOF
    #! /bin/bash
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    echo "ssh-rsa ${resource.certificate_ca.ssh_key.public_key_ssh.contents}" >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
  EOF

  destination = "${data("temp")}/init.sh"
}

resource "remote_exec" "vm_init" {
  depends_on = ["resource.template.vm_init"]
  target     = resource.container.vm1.id

  command = [
    "/bin/bash",
    "/init/init.sh"
  ]
}