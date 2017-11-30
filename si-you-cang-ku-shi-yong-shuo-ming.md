# 私有仓库使用说明


## 私有仓库地址
10.142.55.199:5006
暂不分开发/发布, 

私有仓库命名规则:
+ basin基础库,以basin前缀命名,例如:
basin/py27-ws

+ 由业务系统各自构建的库,以业务系统前缀命名, 例如:
bidspy/publisher


## 使用过程:
1. 配置客户端

    PRIVATE_REGISTRY=10.142.55.199
    ```
    echo '{"insecure-registries":["'${PRIVATE_REGISTRY}':5006"]}' > /etc/docker/daemon.json
    ```

2. 私有仓库浏览
访问地址: http://10.142.55.199:18080/
能够浏览当前私有仓库版本信息.

3. 获取仓库版本

    ~~~
    docker pull 10.142.55.199:5006/basin/py27-ws:1.0
    ~~~

4. 镜像上传
    当前

# 持续构建说明




镜像依赖