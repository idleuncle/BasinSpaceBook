# 研发环境地址

## 环境变量

**必须**
~~~
export BASIN_HOST=10.142.55.199
export BASINSPACE_ROOT=/data/BasinSpace
export PRIVATE_REGISTRY=10.142.55.199:5006
echo "export PRIVATE_REGISTRY=10.142.55.199:5006" >> ~/.bashrc
~~~

**可选**
~~~
export REGISTRY_DATA_DIR=/mnt/docker/docker-registry-basinspace/config/private_registry/data/docker/registry/v2
~~~



- 内网服务:

    * gitlab: [http://BASIN_HOST:50080](http://BASIN_HOST:50080)
    * 镜像仓库: [http://BASIN_HOST:5009](http://BASIN_HOST:5009)
    * 资源服务: [http://BASIN_HOST:9997](http://BASIN_HOST:9997)
    * 私有仓库: http://BASIN_HOST:5006
    * 部署服务: http://BASIN_HOST:8081/jenkins
    * 私有仓库浏览: http://BASIN_HOST:18080

    * release版本下载: http://BASIN_HOST:9997/release
    * stable版本下载: http://BASIN_HOST:9997/stable
    
- 外网服务:

需配置hosts
~~~
139.196.106.149 gitlab.yirong.win
139.196.106.149 redmine.yirong.win
139.196.106.149 gitbook.yirong.win
139.196.106.149 jenkins.yirong.win
139.196.106.149 ssh199.yirong.win
139.196.106.149 portal.yirong.win
~~~

    * gitbook: http://gitbook.yirong.win:10000/
    * trello: https://trello.com/b/lY0uCQ2q/basinspace
    * 部署服务: http://jenkins.yirong.win:10000/jenkins
    * gitlab_ssh: ssh://git@ssh199.yirong.win:10022/basinspace/bidspy.git
    
    

## 服务器列表:

| IP地址 |  操作系统 | 账户/密码 | 分配的资源 | 使用者 | 用途 | 端口映射 | 备注
| --- | --- | --- | --- | --- | --- | --- | --- |
| 192.168.2.100 | centos7 | root/vagrant | 2G | basin | 编译服务器  | | 映射BASIN_HOST|
| 192.168.2.101 | centos7 | root/vagrant | 2G | basin | 测试服务器 | | 映射BASIN_HOST|
| 192.168.2.110 | centos7 | root/vagrant | 2G | basin | bidspy服务器 | 7000->17000 <br>8880->18880 <br>5000->15000 <br>5001->15001 <br>11081->11082| 映射BASIN_HOST|



## 内网服务器端口列表

1. private registry 5006
3. mirror registry 5009
4. jenkins 9002
5. pyspider 5000
6. basin-spider 5001
7. universal\_backend 6000
8. etl 7000
9. bidspy 12000
10. assets 9997 \(静态服务器\)
11. hugo 9998 (静态站点发布)



## 系统环境启停列表

主要在gpu服务器

* dockerd:
    * 启动: sudo service docker start
    * 停止: sudo service docker stop

* gitlab: 
  * 路径: /mnt/docker/docker-gitlab-basinspace
  * 启动:
      make start
  * 停止:
      make stop

* gitbook: 
    * 路径: /mnt/docker/docker-gitbook-basinspace
    * 启动: docker-compose up -d
    * 停止: docker-compose stop

* private\_registry:        
    * 路径: /mnt/docker/docker-registry-basinspace

    * 启动: start\_registry.sh 
    * 停止: stop\_registry.sh

* jenkins: jenkins\(暂定\)
    + 路径: /apps/apache-tomcat-8.5.23/bin
    + 启动: sh startup.sh
    + 停止: sh shutdown.sh

* assets\(静态资源服务\): 
    * 路径: /mnt/docker/bidspy\_publish

    * 启动: docker-compose up -d
    * 停止: docker-compose stop

* 静态站点:
    * 路径: /home/qchen/BasinSpace/apps/portal
    * 启动: sh  start.sh
    * 停止: sh stop.sh



