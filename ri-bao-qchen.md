## 2017-11-02

1. 处理docker 私有仓库作为镜像,被其他机器拉取,经过测试私有仓库是有效果,是从私有仓库中拉去.但是还存在无网环境下切换失败,待解决.
2. 源码迁移到gitlab 内网环境. [](/yuan-ma-qian-yi-bu-zou.md)
3. install.sh的部署脚本拆分,之前install.sh脚本是全部整合在一起,当前拆成多个脚本来运行.

## 2017-11-07

1. docker-book 迁移至内网
2. 静态web 资料站点,建立以及静态资料获取(docke等)
3. 外部依赖管理, 脚本修复

## 2017-11-08
1. bidspy build vagrant 测试以及脚本调整
2. pyspider 提供函数库定义

## 2017-11-09
1. spider爬虫->[2]docker 精简
    + pyspider docker 精简,由原来800M.精简大约400M,其中pyantomjs 无法在alpine中运行,需要查找安装包.
2. Packaging->[3]部署服务器搭建
    + docker container 编译部署镜像  
        + 测试docker 中编译.就需要在docker container 中build Dockerfile, (docker in docker) 比较麻烦,暂时放弃.
    + varant 部署镜像
        + dockerd & 远程启动失败.
3. 分析基础镜像部署依赖包,列出依赖包.
    