# 容器网络架构


## 概述

Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口。对于容器服务的编排，在市场上存在着大量容器及相应的云服务可用。容器技术和编排引擎通常是结合在一起使用的，因而常被包含在同一工具中。云端提供的服务被称为CaaS (容器即服务)，其中“用户只为他们所使用的资源付费，例如计算实例、负载均衡和调度能力”。所以容器治理成为一大痛点。容器治理包含了如下一系列任务：调度（包括部署、复制、扩展、复活、重新调度、升级、降级等）、资源管理（内存、CPU、存储空间、端口、IP、镜像等）和服务管理（即使用标签、分组、命名空间、负载均衡和准备就绪检查将多个容器编排在一起）。


## 解决方案


容器编排中很重要的一部分就是容器网络，容器网络中最重要的应该是网络隔离和网络定位。Docker Swarm能够把多台主机构建成一个docker的集群，用户可以只和swarm api操作来管理多个主机上的docker，再结合上Overlay的网络实现简单的容器调度和互访。

Swarm的特性：

- 工作节点的注册和发现 
- 管理节点收集集群中所有的信息 
- 管理节点支持HA 
- 管理节点能感知集群的变化，在节点挂掉后重新调度上面的container 
- 提供filter和scheduler的调度策略调度集群里的容器

也就是说Swarm 支持：

- 编排容器到指定节点
- 创建隔离网络
- 查询容器所在网络(inspect)


Swarm架构图：

![](http://img.blog.csdn.net/20170312172756441?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJUaXRhbg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

## 验证模型

以bidspy为例，流程为:

digraph G {

    controller -> swarm [label="网络创建/服务启动/信息获取等控制命令"];
    swarm -> subnet_proxy [label="创建代理网络"];
    swarm -> subnet_bidspy [label="创建应用网络"];
    swarm -> subnet_storage [label="创建存储网络"];
    swarm -> bidspy [label="创建服务"];
    bidspy -> subnet_bidspy [label="连接网络"]
    bidspy -> subnet_proxy [label="连接网络，对外访问入口"]
    bidspy -> subnet_storage [label="连接网络"]
    user -> subnet_proxy [label="访问应用"]

}

![](/assets/S0[Q$BM1ZSC_BQ4[6[]2]K5.png)


## 总结

