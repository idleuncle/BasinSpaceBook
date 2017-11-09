
## 端口列表

2. ~~Harbor 8000~~
3. private registry 5006
4. mirror registry 5009
5. jenkins 9002
6. pyspider 5000
7. basin-spider 5001
8. universal\_backend 6000
9. etl 7000
10. bidspy 12000
11. assets 9997 (静态服务器)

## 研发环境地址

+ gitlab: http://10.142.55.199:50080
+ mirror: http://10.142.55.199:5009
+ assets: http://10.142.55.199:9997

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



