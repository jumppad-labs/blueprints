# VM and Nomad Jumppad example for Codemotion

## Resources
* 2x Ubuntu Containers
* 1x Nomad Server
* 3x Nomad Clients
* 1x Consul Server
* 1x Nginx

## Running the example

First install `jumppad`

https://jumppad.dev/docs/introduction/installation

Then from the codemotion folder in this repo run the following command:

```shell
jp up
```

```shell
2023-05-10T09:19:07.008+0200 [INFO]  Parsing configuration: path=/Users/nicj/code/github.com/jumpppad-labs/examples/codemotion
2023-05-10T09:19:07.058+0200 [INFO]  Creating resources from configuration: path=/Users/nicj/code/github.com/jumpppad-labs/examples/codemotion
2023-05-10T09:19:07.059+0200 [INFO]  Creating ImageCache: ref=default
2023-05-10T09:19:10.742+0200 [INFO]  Creating Output: ref=NOMAD_ADDR
2023-05-10T09:19:10.745+0200 [INFO]  Creating Network: ref=resource.network.vpc1
2023-05-10T09:19:10.898+0200 [INFO]  Creating ImageCache: ref=default
2023-05-10T09:19:11.184+0200 [INFO]  Creating Output: ref=CONSUL_HTTP_ADDR
```

To destroy all the resources run `jp down`.