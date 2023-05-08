ARG TARGETARCH

FROM ubuntu:latest

RUN apt update && apt install -y openssh-server supervisor zip nginx

WORKDIR /tmp

# Remove default nginx config
RUN rm /etc/nginx/sites-enabled/default

# Install Consul
RUN wget https://releases.hashicorp.com/consul/1.15.2/consul_1.15.2_linux_amd64.zip -O ./consul.zip && \
  unzip ./consul.zip && \
  mv ./consul /usr/local/bin/consul && \
  chmod +x /usr/local/bin/consul

# Install Consul Template
RUN wget https://releases.hashicorp.com/consul-template/0.31.0/consul-template_0.31.0_linux_amd64.zip  -O ./consul_template.zip && \
  unzip ./consul_template.zip && \
  mv ./consul-template /usr/local/bin/consul-template && \
  chmod +x /usr/local/bin/consul-template

CMD ["/usr/bin/supervisord"]