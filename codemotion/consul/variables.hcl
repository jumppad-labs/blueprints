variable "network_id" {
  default = ""
}

variable "consul_version" {
  default = "consul:1.15.2"
}

variable "consul_port" {
  default = 8500
}

variable "consul_nodes" {
  default = 3
}

output "consul_server" {
  value = resource.container.server-1.fqrn
}