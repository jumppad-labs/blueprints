resource "network" "vpc1" {
  subnet = "10.5.0.0/16"
}

module "vms" {
  source = "./vms"
  variables = {
    network       = resource.network.vpc1.id
    consul_server = module.consul.output.consul_server
  }
}

module "nginx" {
  source = "./nginx"
  variables = {
    network       = resource.network.vpc1.id
    consul_server = module.consul.output.consul_server
  }
}

module "consul" {
  source = "./consul"

  variables = {
    consul_nodes = 1
    network      = resource.network.vpc1.id
  }
}

module "vms" {
  source = "./vms"
  variables = {
    network       = resource.network.vpc1.id
    consul_server = module.consul.output.consul_server
  }
}

module "nomad" {
  source = "./nomad"

  variables = {
    network       = resource.network.vpc1.id
    consul_server = module.consul.output.consul_server
    client_nodes  = 3
  }
}

output "vm_ssh_key" {
  value = module.vms.output.ssh_private_key
}

output "vm_ssh_addr" {
  value = module.vms.output.ssh_addr
}

output "vm_ssh_port" {
  value = module.vms.output.ssh_port
}

output "ssh_command" {
  value = "ssh root@localhost -p ${module.vms.output.ssh_port} -i ${module.vms.output.ssh_private_key}"
}

output "CONSUL_HTTP_ADDR" {
  value = "http://localhost:8500"
}

output "NOMAD_ADDR" {
  value = "http://localhost:4646"
}


//output "consul_server_addr" {
//  value = module.consul.output.consul_server
//}