## 

注意，创建的时候加

Usage: docker-machine create [OPTIONS] [arg...]

docker-machine create -d virtualbox --engine-registry-mirror https://mytfd7zc.mirror.aliyuncs.com  --engine-insecure-registry 10.142.55.199:5006 node-1
 
docker-machine create -d virtualbox --engine-registry-mirror https://mytfd7zc.mirror.aliyuncs.com  --engine-insecure-registry 10.142.55.199:5006 node-2
 
docker-machine create -d virtualbox --engine-registry-mirror https://mytfd7zc.mirror.aliyuncs.com  --engine-insecure-registry 10.142.55.199:5006 node-3


删除所有docker machine
docker-machine rm -y $(docker-machine ls -q)

重置docker-machine env
eval "$(docker-machine env -u)"

创建网络
docker network create --driver overlay xxxname

查看网络
docker network ls

查看节点
docker node ls

创建服务
docker service create --name go-demo \
  -e DB=go-demo-db \
  --network go-demo \
  --network proxy \
  vfarcic/go-demo

查看log
docker service logs go-demo

log 例子
```
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
8n7vjyuvnmw7        go-demo-db          replicated          0/1                 mongo:latest
```

这里 0/1 表示还没有实例，应该是卡在docker pull 状态。当网络出问题时，可能永远pull不下来。


## swarm

需要运行在manager 的service要加参数

--constraint 'node.role==manager'

比如自动注册

docker service create --name swarm-listener \
    --network proxy \
    --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
    -e DF_NOTIFY_CREATE_SERVICE_URL=http://proxy:8080/v1/docker-flow-proxy/reconfigure \
    -e DF_NOTIFY_REMOVE_SERVICE_URL=http://proxy:8080/v1/docker-flow-proxy/remove \
    --constraint 'node.role==manager' \
    vfarcic/docker-flow-swarm-listener

## 创建子网

$ docker network create \
  --driver overlay \
  --subnet 10.0.9.0/24 \
  --gateway 10.0.9.99 \
  my-network

- You should create overlay networks with /24 blocks (the default), which limits you to 256 IP addresses
- If you need more than 256 IP addresses, do not increase the IP block size. You can either use dnsrr endpoint mode with an external load balancer, or use multiple smaller overlay networks. See Configure service discovery for more information about different endpoint modes.


注: 192.168.1.x  子网掩码 255.255.255.0 和  192.168.1.x/24  （*nix表示法）意思一致。

