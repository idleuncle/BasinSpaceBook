# basin swarm 平台搭建


## 流程

1. 前端界面，用户上传其Dockerfile或者使用现成docker镜像。 (可以接入basin平台提供的公共服务，如mongodb，redis)
2. 配置各个容器运行实例数量，连接网络，资源
3. 网络由用户指定划分，如未指定，则全部运行于同一网络 (可以连接公共服务的网络)
4. 将用户配置组装成docker-compose.yml (用户id区分 stack deploy时候的name 要拼上id)
5. worker 执行相关命令（增删改查swarm cluster 或者其中的service）
6. monitor 使用swarm api监控

------------------------

## 样例 - bidspy swarm 集群的构建


#### set env

. env.sh

#### load docker images

sh ./load_docker_images.sh

#### run registry
docker service create --name registry --publish published=$PR_PORT,target=$PR_PORT basin/registry:2

#### push images

docker-compose push -f docker-compose-swarm.yml

#### run 

docker stack deploy --compose-file docker-compose-swarm.yml bidspy


注：会自动使用bidspy_IMAGENAME 作为服务名， 比如 bidspy_basin-spider  的image 是 127.0.0.1:5000/bidspy/basin-spider:latest

#### remove

docker stack rm bidspy

#### 定位服务


docker service ps helloworld 
