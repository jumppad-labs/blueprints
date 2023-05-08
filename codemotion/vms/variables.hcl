variable "network" {
  default = ""
}

variable "consul_version" {
  default = "consul:1.15.2"
}

variable "consul_server" {
  default = ""
}

output "ssh_private_key" {
  value = resource.certificate_ca.ssh_key.private_key.path
}

output "ssh_addr" {
  value = resource.container.vm1.fqrn
}

output "ssh_port" {
  value = resource.container.vm1.port[0].host
}