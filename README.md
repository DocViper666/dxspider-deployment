# DXSpider Deployment

This is a deployment project for [DX Spider](http://wiki.dxcluster.org/index.php/Main_Page)
Amateur Radio DX Cluster software, independent of DX Spider development.

This project focuses on easy DX Spider deployment in virtualised/cloud
environments and as such its focus is primarily supporting telnet nodes running
on TCP networks.

This repo adds the connection to a mariadb container and a simple webinterface.
In addition the DXspider container has a ttyd based webconsole to login for sysop activities.



## Running in docker-compose

Rename the file `sample.env` to `.env` and edit it so match your parameters and then
just run the following command to test the configuration:

```sh
docker compose config
```

To download, build and run the containers:

```sh
docker compose up -d --build
```
Use secure passwords including upper and lowercase and numbers.

Note: you might want to change some extra settings inside the
`docker-compose.yml` file itself.

Please ensure that the `CLUSTER_PORT` value equals to that of the
published port in the `docker-compose.yml` file.

If your node started up successfully, at the end of the startup you should
get an output similar to:

```txt
reading database descriptors ...
doing local initialisation ...
orft we jolly well go ...
queue msg (0)
queue msg (0)
```

You can now telnet to your cluster node and use it list like any other telnet
node:

```txt
$ telnet localhost 7300
Trying ::1...
Connected to localhost.
Escape character is '^]'.
login: MY1CALL
MY1CALL
Hello Joe Bloggs, this is MY1CALL-2 in London, England
running DXSpider V1.55 build 0.166
Cluster: 1 nodes, 1 local / 1 total users  Max users 1  Uptime 0 00:08
MY1CALL de MY1CALL-2  4-Oct-2018 0918Z dxspider >
```

If you want to allow external connections to your node, you will need to allow
this traffic on your firewall.

To put down the server, run:

```sh
docker compose down
```

### Sysop Shell

In order to get a sysop shell in your running Docker container:

```sh
docker compose exec cluster sh
```
Or use the ttyd Webconsole on localhost:8080
Login with sysop username and password.
