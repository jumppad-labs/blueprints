job "api" {
  datacenters = ["dc1"]

  type = "service"

  group "api" {
    count = 3

    restart {
      # The number of attempts to run the job within the specified interval.
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    ephemeral_disk {
      size = 30
    }

    network {
      mode = "bridge"
      port "http" {
        to = 9091
      }
    }

    service {
      name = "api"
      tags = ["global", "app"]
      port = "http"
    }

    task "api" {
      driver = "docker"

      logs {
        max_files     = 2
        max_file_size = 10
      }

      env {
        LISTEN_ADDR = "0.0.0.0:9091"
        MESSAGE     = "Hi I am running on Nomad"
        NAME        = "API - ${node.unique.name}"
        SERVER_TYPE = "http"
      }

      config {
        image = "nicholasjackson/fake-service:v0.24.2"
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }
    }
  }
}