resource "template" "consul_config_1" {
  source = <<-EOF
    service {
      id = "nginx-1"
      name = "nginx"
      port = 80
    }
  EOF

  destination = "${data("consul_config")}/nginx.hcl"
}

resource "template" "consul_template" {
  source = <<-EOF
    consul {
      address = "localhost:8500"

      retry {
        enabled  = true
        attempts = 12
        backoff  = "250ms"
      }
    }

    template {
      source      = "/etc/nginx/conf.d/load-balancer.conf.ctmpl"
      destination = "/etc/nginx/conf.d/load-balancer.conf"
      perms       = 0600
      command     = "/etc/init.d/nginx reload"
    }
  EOF

  destination = "${data("nginx")}/consul_template.hcl"
}

resource "template" "nginx_template" {
  source = <<-EOF
    upstream backend {
    {{- range service "api" }}
      server {{ .Address }}:{{ .Port }};
    {{- end }}
    }

    server {
       listen 80;

       location / {
          proxy_pass http://backend;
       }
    }
  EOF

  destination = "${data("nginx")}/nginx_template.hcl"
}

resource "container" "nginx" {
  network {
    id = variable.network
  }

  image {
    name = "nicholasjackson/nginx:0.1.0"
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
    destination = "/config/consul/service.hcl"
  }

  volume {
    source      = resource.template.consul_template.destination
    destination = "/config/consul_template/consul_template.hcl"
  }

  volume {
    source      = resource.template.nginx_template.destination
    destination = "/etc/nginx/conf.d/load-balancer.conf.ctmpl"
  }

  ## Public HTTP
  port {
    host   = 80
    local  = 80
    remote = 80
  }

  environment = {
    NAME              = "nginx"
    CONSUL_DATACENTER = "dc1"
    CONSUL_SERVER     = variable.consul_server
  }
}