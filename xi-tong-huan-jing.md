## 研发环境地址

- 内网服务:

    * gitlab: [http://10.142.55.199:50080](http://10.142.55.199:50080)
    * 镜像仓库: [http://10.142.55.199:5009](http://10.142.55.199:5009)
    * 资源服务: [http://10.142.55.199:9997](http://10.142.55.199:9997)
    * 私有仓库: http://10.142.55.199:5006
    * 部署服务: http://10.142.55.199:8081/jenkins

    * release版本下载: http://10.142.55.199:9997/release
    * stable版本下载: http://10.142.55.199:9997/stable
    
- 外网服务:

    * gitbook: http://115.28.208.122:16689/
    * trello: https://trello.com/b/lY0uCQ2q/basinspace
    * 部署服务: 139.196.106.149:16399/jenkins
    




## 端口列表

1. private registry 5006
3. mirror registry 5009
4. jenkins 9002
5. pyspider 5000
6. basin-spider 5001
7. universal\_backend 6000
8. etl 7000
9. bidspy 12000
10. assets 9997 \(静态服务器\)


## 镜像列表

1. alpine 3.6
2. centos 7.4.1708
3. jessie-20171009
4. frolvlad/alpine-oraclejdk8 full
5. golang 1.9.1
6. nginx 1.13.5
7. redis 3.2.11
8. mongo 3.0.15
9. python:2.7-alpine
10. python:2

## 系统环境启停列表

主要在gpu服务器\(10.142.55.199\)

* gitlab: /mnt/docker/docker-gitlab-basinspace
  * 启动:
      make start
  * 停止:
      make stop
* gitbook: /mnt/docker/docker-gitbook-basinspace

  * 启动:
      docker-compose up -d
  * 停止:
       docker-compose stop

* private\_registry: /mnt/docker/docker-registry-basinspace

  * 启动:
      start\_registry.sh 
  * 停止:
      stop\_registry.sh

* jenkins: jenkins\(暂定\)

* assets\(静态资源服务\): /mnt/docker/bidspy\_publish

  * 启动:
      docker-compose up -d
  * 停止:
      docker-compose stop



