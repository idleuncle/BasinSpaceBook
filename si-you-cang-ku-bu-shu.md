# 私有仓库搭建/部署
## 仓库分类

1. 私有开发仓库
    + 提供开发使用,开发人员可以pull, push镜像
2. 私有部署仓库(生产用)
    + 提供部署必要的镜像,只需要pull
3. 镜像仓库
    + 提供用户pull拉取仓库中镜像.

basinspace 私有仓库地址: http://BASIN_HOST:5006
basinspace 镜像地址: http://BASIN_HOST:5009
## 部署私有仓库(private registry)
工作流程:
开发人员能够pull, push镜像,pull 时需要指定url地址

* 安装私有仓库

```
docker pull registry:2.6.2
```

* config.yml 配置

~~~
version: 0.1
log:
  fields:
    service: registry
storage:
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
   enabled: true
    interval: 10s
    threshold: 3
~~~

* docker-compose.yml配置

```
version: '2'
services:
  registry:
    image: registry:2.6.2
    container_name: basinspace_registry
    restart: always
    volumes:
      - ${PWD}/data:/var/lib/registry
      - ${PWD}/config.yml:/etc/registry/config.yml
    ports:
      - 5006:5000
    command:
      ["serve", "/etc/registry/config.yml"]
```

* 运行docker registry镜像

```
dock-compose up
```

运行后私有仓库地址为 [http://$](http://127.0.0.1:5006)PRIVATE\_REGISTRY[:500](http://127.0.0.1:5006)6

[**$**](http://127.0.0.1:5006)**PRIVATE\_REGISTRY** 为设定部署的ip地址

##  私有仓库使用

客户端需要修改docker配置

```
echo '{"insecure-registries":["'${PRIVATE_REGISTRY}':5006"]}' > /etc/docker/daemon.json
```

## 通过web浏览器

http://

### 获取私有仓库列表

```
curl http://$PRIVATE_REGISTRY:5006/v2/_catalog
```

返回

```
{"repositories":\["libs/docker.io/alpine"\]} 说明当前仓库已有的镜像
```

### 获取镜像列表

```
curl http://$PRIVATE_REGISTRY:5006/v2/libs/docker.io/alpine/tags/list
```

返回

```
{"name":"libs/docker.io/alpine","tags":\["3.6"\]} 显示可以提供下载的tag列表
```

### 获取alpine镜像

```
docker pull $PRIVATE_REGISTRY:5006/libs/docker.io/alpine:3.6
```

### 上传本地镜像到私有仓库

```
docker tag docker.io/alpine:3.6 127.0.0.1:5000/libs/docker.io/alpine:3.6
docker push $PRIVATE_REGISTRY:5006/libs/docker.io/alpine:3.6
```

```
备注: docker.io/alpine:3.6 为docker hub上下载的镜像
```

### 打包镜像\(导出\)

```
docker save docker.io/registry > registry2.6.2.tar
```

### 镜像导入

```
docker load < registry2.6.2.tar
```
## 部署镜像仓库(mirror)

工作流程:
镜像仓库先去remoteurl指定的地址同步index数据,当用户pull 镜像时候,先查找是否存在该镜像,如果本地有镜像直接返回,本地没有该镜像,会同步remoteurl下载并返回镜像给客户端,最终在私有镜像仓库中会存有一份镜像,下次用户在pull直接从镜像仓库中返回,提高速度.


在config.yml配置中增加proxy remoteurl选项

config.yml 配置

~~~
 version: 0.1
 log:
   fields:
     service: registry
 storage:
   cache:
     blobdescriptor: inmemory
   filesystem:
     rootdirectory: /var/lib/registry
 http:
   addr: :5000
   headers:
     X-Content-Type-Options: [nosniff]
 health:
   storagedriver:
     enabled: true
     interval: 10s
     threshold: 3
 proxy:
   remoteurl: https://registry-1.docker.io
~~~     

* docker-compose.yml配置

```
version: '2'
services:
  registry:
    image: registry:2.6.2
    container_name: basinspace_registry
    restart: always
    volumes:
      - ${PWD}/data:/var/lib/registry
      - ${PWD}/config.yml:/etc/registry/config.yml
    ports:
      - 5009:5000
    command:
      ["serve", "/etc/registry/config.yml"]
```




## 使用镜像仓库

客户端需要修改docker配置

```
echo '{"registry-mirrors":["http://'${PRIVATE_REGISTRY}':5009"]}' > /etc/docker/daemon.json

例如:

{
  "registry-mirrors": ["http://10.142.55.199:5009"],
  "insecure-registries": ["10.142.55.177:8000","10.142.55.199:5006"]
}
        



```


### 镜像获取
```
docker pull redis:3.0.7
```




# 3.已知问题
1. 其他机器能够从私有仓库拉去过程每次都要联网一下.需验证排查.无网络情况就无法启动.
    + **解决**: 在无网络环境下,只能使用私有仓库,不能把私有仓库配置成mirror,mirror默认需要配置remote_url,该配置需要联网同步
