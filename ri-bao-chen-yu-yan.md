# 2017-12-11

1. 构建swarm环境， bidspy 使用swarm 接入集成测试

# 2017-12-08

1. 弃用docker-machine, 使用vagrant 构建swarm环境

# 2017-12-07

1. docker swarm network 不互通，未解决
2. 前端ant相关技术深入了解


# 2017-12-06

1. docker swarm 运行错误排查
2. 设计文档与架构图

# 2017-12-05

1. docker swarm 运行实验，但是没办法运行demo
2. 设计文档与架构图


# 2017-12-04

1. docker compose 集成测试，解决持续集成的一些问题
2. 学习了下前端框架ant 和 dva ，尝试将demo 跑起来https://pro.ant.design/docs/getting-started-cn


# 2017-11-29

1. 订单demo 与 scheduler 的接口交互问题解决
2. docker compose 集成测试

# 2017-11-28

1. 将订单demo网站UI界面和接口
2. docker compose 集成测试
3. 发现订单demo与爬虫通讯问题，解决

# 2017-11-27

1. 将订单网站用Django重写
2. UI界面和接口重写


# 2017-11-26

1. docker 镜像依赖重整，重新构建基础镜像，依赖图
2. 考虑将 worker 从scheduler 中拆出
3. 文档整理

# 2017-11-25

1. scheduler 定时无法执行的bug
2. pipeline 任务重构转移到scheduler 的worker中
3. docker machine learning 镜像构建，基础镜像构建

# 2017-11-22

1. scheduler jobs 启停管理
2. scheduler 定时设计，达到截止时间自动停止job
3. 架构图，文档编辑


# 2017-11-21

1. scheduler jobs管理 restful 接口
2. job 规范定义（需要预置 代码，写在项目中，订单服务需要知道这些job名，这个问题）
3. 理清 publisher (订单增删改查) -> scheduler (定时任务) -> pipeline(还有worker while True 读数据问题)


# 2017-11-20

1. scheduler jobs管理，测试
2. scheduler 与publisher 的接口
3. 整理文档，部署图等


# 2017-11-17

发布网站 1. 选用hugo 构建静态站点， 学习用法。
发布网站 2. 与每日构建集成
Pipeline 3. 集成apscheduler


# 2017-11-16

Deploy 文档
Deploy 测试
Repository 集成测试发现有错，修复
Pipeline 3 集成apscheduler，无法在job中创建job，未解决

# 2017-11-15

Repository 3 单元测试脚本
Repository 4  db接入sqlite，通过webapi与db操作相关接口测试
Repository 5 安装成python lib 后出现的问题修复
Pipeline 1 转换成 scheduler， 定时检查订单，执行任务
Deploy 文档


# 2017-11-14

1. Repository 2, Pipeline 3 
2. Repository 2 
3. Pipeline 1, Repository 1
4. Repository 1


# 2017-11-13

1. Packaging 10 
2. Packaging 6, 7, 10
3. Packaging 6, 7
4. Packaging 4, 12

# 2017-11-10

6. Development 10 ,   Packaging 2

7. Packaging 4 , 7, 8

8. Packaging 4 , 7, 8

# 2017-11-09

1. 文档修改， 综合几个python web service的依赖， 制作基础镜像

2. 由脚本进行环境变量设置（没有办法直接反应的终端，需要用户自己执行）， docker registry webui

3. 外部依赖管理, 整体部署测试

---

# 2017-11-02

1. 缩小镜像，将可用的Dockfile提交。 遗留问题：extractor 无法构建 ， 暂时搁置

2. 学习 ansible ，安装时碰到一些编译问题， 查找是否有现成的github 项目可用

3. 解决安装问题，尝试一些基本部署操作， 运行测试有问题 [https://superuser.com/questions/1264711/ansible-all-m-ping-unreachable](https://superuser.com/questions/1264711/ansible-all-m-ping-unreachable) ， 先搁置。 直接写playbook

4. 编写多机部署的 ansible playbook ，未完

# 2017-11-03

1. ansible 自动将配置playbook 中的hostname 写入所有客户机。 安装步骤分割为 common, registry, others 。

2. vagrant 多机环境搭建， 安装部署脚本修改， playbook 错误修正 , ansible ssh 授权问题解决

3. 和陈牵商量统一 安装脚本配置项， 一些路径统一。  playbook 错误修正 。

4. ansible 多机部署基本解决。 就外部依赖包，如docker 二进制包等决定 放在外网的静态资源服务中。 build的时候拉取 。

# 2017-11-06

1. 修改文档， 安装脚本需要分为2种，因为 源码的安装脚本 和 发布包的安装脚本 配置混淆导致  一些错误浪费了时间。已经整好。 考虑要把 docker 镜像名的 配置单独放一个文件。验证修改脚本后 的ansible 安装

2. ansible 启动服务出错

   ```
   [root@host01 scripts]# docker run -d -p 5006:5000 --restart=always --name registry registry:2.6.2               
   28135e1c1e5e3a53aaf220a891b3ace31567e1b105c9547594b75003067884cd                                                
   docker: Error response from daemon: oci runtime error: container_linux.go:265: starting container process caused
   "process_linux.go:368: container init caused \"process_linux.go:351: running prestart hook 0 caused \\\"fork/ex
   ec /data/bidspy-yychen/dist/scripts/docker-17.09.0-ce/dockerd (deleted): no such file or directory\\\"\"".
   ```

   暂时找不到解决方法  
   问题描述

   1. dockerd 路径 /usr/local/bin/dockerd
   2. dockerd 服务已经启动
   3. docker load &lt; xxxx 可以导入镜像
   4. docker images   能够列出镜像
   5. docker run 无法启动 container

   可能跟playbook的执行脚本的环境有关系，导致找错了路径.

   vagrant 完整测试每次都要destroy 再 up 很浪费时间，不知道有什么办法解决

3. 发布与部署文档修正， 写了一些测试服务的脚本， extractor docker镜像缩小再研究了下

# 2017-11-07

1. 开发说明文档， 开发环境搭建脚本

2. 发布安装文档， 发布包测试， 发布脚本

3. 外部依赖管理, 脚本修复

# 2017-11-08

1. 文档修改， 开发环境搭建脚本

2. 发布包测试， 发布脚本测试， ansinble 多机部署（解决之前的dockerd not found，但是好像有了新问题）

3. 外部依赖管理, 整体部署测试



