## 系统环境

主要在gpu服务器(10.142.55.199)

+ gitlab: /mnt/docker/docker-gitlab-basinspace
    + 启动:
        make start
    + 停止:
        make stop
+ gitbook: /mnt/docker/docker-gitbook-basinspace
    + 启动:
        docker-compose up -d
    + 停止:
         docker-compose stop

+ private_registry: /mnt/docker/docker-registry-basinspace
    + 启动:
        start_registry.sh 
    + 停止:
        stop_registry.sh

+ jenkins: jenkins(暂定)

+ assets(静态资源服务): /mnt/docker/bidspy_publish
    + 启动:
        docker-compose up -d
    + 停止:
        docker-compose stop
