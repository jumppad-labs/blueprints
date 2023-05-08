ARG TARGETARCH

FROM ubuntu:latest

RUN apt update && apt install -y openssh-server supervisor zip

RUN mkdir /run/sshd

WORKDIR /tmp

# Install fake-service
RUN wget https://github.com/nicholasjackson/fake-service/releases/download/v0.25.1/fake_service_linux_amd64.zip -O ./fake-service.zip && \
  unzip ./fake-service.zip && \
  mv ./fake-service /usr/local/bin/fake-service && \
  chmod +x /usr/local/bin/fake-service

# Install Consul
RUN wget https://releases.hashicorp.com/consul/1.15.2/consul_1.15.2_linux_amd64.zip -O ./consul.zip && \
  unzip ./consul.zip && \
  mv ./consul /usr/local/bin/consul && \
  chmod +x /usr/local/bin/fake-service

CMD ["/usr/bin/supervisord"]