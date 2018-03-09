# docker hadoop 验证
## 概述
调研容器化快速部署hadoop标准集群方式
### 验证点
1. docker多机下环境完全分布式部署
2. hadoop存储

### 试验1 docker多机下完成分布式部署
依赖:
1. 阿里云3台服务器
    + 139.196.104.187
    + 139.196.105.206
    + 139.196.105.70
2. hadoop镜像,使用kiwenlau/hadoop:1.0

### 操作步骤:
1. 创建srawm集群
> docker swarm init --listen-addr 139.196.104.187:2377 --advertise-addr  139.196.104.187
生成docker join token ,
2. 其他节点执行,由第一步返回的token命令,加入到集群环境中.
> docker swarm join --token SWMTKN-1-3sqlpjvld3xfr96vg5tqgp6p0auadjzacghvci46bvi62odmih-74iz2vw91e2sn186u5q35k026 139.196.104.187:2377 

3. 创建专有网络
> docker network create --opt encrypted --driver overlay --attachable hadoop

4. 启动master容器
> docker service create -t --name hadoop-master \
--hostname hadoop-master \
--network hadoop \
--detach=false \
--replicas 1 \
--publish mode=host,target=8088,published=8088,protocol=tcp \
--publish mode=host,target=50070,published=50070,protocol=tcp \
kiwenlau/hadoop:1.0

5. 启动slave 2个容器
>docker service create -t --name hadoop-slave1 \
--hostname hadoop-slave1 \
--network hadoop \
--detach=false \
--replicas 1 kiwenlau/hadoop:1.0 
> docker service create -t --name hadoop-slave2 \
--hostname hadoop-slave2 \
--network hadoop \
--detach=false \
--replicas 1 kiwenlau/hadoop:1.0 

6. 启动hadoop master 
查看hadoop-master 在哪一台服务器,进入容器,执行 sh start-hadoop.sh
> docker service ps hadoop-master( 查看在哪一台节点运行)
> docker exec -it hadoop-master.1.7n3oerxlbmgelqjit0vnzkw86 /bin/bash (进入master容器,name名字可能不一样)
> sh start-hadoop.sh

7. 测试wordcount 例子
> sh  run-wordcount.sh 能够查看统计的word个数.

问题点:
1. 集群部署时候,访问8080 无法访问,单机部署的时候能够正常访问(容器内部也能够访问) 待解决.
2. 容器启动时候.尝试挂载了存储目录,能够正常使用hdfs命令读写文件,但是再重新启动时候,hdfs命令读不到原先的文件.