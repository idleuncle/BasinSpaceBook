## 部署说明
使用vagrant 虚拟机作为部署服务器,使用jenkins(暂定)进行构建.

## 环境配置说明
vagrant 路径: /mnt/docker/jenkins/vagrant_build_machine
ip: 192.168.2.100
user: root
pwd: vagrant


## 部署操作说明
+ **web 操作**
    1. 登录: http://115.28.208.122:17000/jenkins
账号: jenkins/jenkins

    2. 点击编译项目 build_bidspy 进行编译.

+ **命令行操作**
    ~~~
    启动编译命令
    curl -X POST http://jenkins:jenkins@115.28.208.122:17000/jenkins/job/build_bidspy/build
    ~~~
    
生成安装包文件: /root/workspace/build_bidspy/dist



## 部署测试说明
1. 分发编译后安装包到测试服务器,进行测试
2. 

##  问题
1. 需要增加发布服务器/ftp等,存放编译后安装包
2. 

