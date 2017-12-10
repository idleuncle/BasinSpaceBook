# 私有仓库使用说明

## 私有仓库分类
私有仓库暂不分开发/发布,统一存在该仓库中.

+ basin
    + basin基础库,以basin前缀命名,例如:
basin/py27-ws

    
+ 业务系统
    + 由业务系统各自构建的库,以业务系统前缀命名, 例如:
bidspy/publisher

+ test
    + test 测试库, 用于测试使用,例如:
    test/portworx

## 私有仓库依赖图
 

![](/graphics/docker_deps.png)



## 使用过程
**1. 配置客户端**
    
    ```
    export PRIVATE_REGISTRY=10.142.55.199

    echo '{"insecure-registries":["'${PRIVATE_REGISTRY}':5006"]}' > /etc/docker/daemon.json
    ```

**2. 私有仓库浏览**

    访问地址: http://10.142.55.199:18080/

**3. 获取仓库版本**

    ~~~
    docker pull 10.142.55.199:5006/basin/py27-ws:x.x
    ~~~

**4. 镜像上传**

    ~~~
    docker tag py27-ws:1.0 10.142.55.199:5006/basin/py27-ws:x.x
    docker push 10.142.55.199:5006/basin/py27-ws:x.x
    ~~~

**5. 镜像删除**

    使用第三方工具进行删除,操作需要登入到10.142.55.199服务器进行操作.
    ~~~
    export REGISTRY_DATA_DIR=/mnt/docker/docker-registry-basinspace/config/private_registry/data/docker/registry/v2
    sudo -E delete_docker_registry_image --image basin/py27-ws:x.x
    ~~~
    
    
!! 删除由basin组成员删除.
    
delete_docker_registry_image 使用说明:
https://github.com/burnettk/delete-docker-registry-image
    
## 镜像维护
1. basin镜像由basin 组用户进行维护.
2. 业务系统镜像由开发人员自行维护.

备注:暂无用户权限区分,增加insecure-registries配置均能修改.

##### 新增/修改basin镜像流程
1. 通知basin组人员@陈牵,@陈予言,增加镜像或修改镜像
2. basin组人员评估是否已有镜像或确需要增加镜像
3. basin组人员增加/修改新镜像,并通知开发组成员



# 持续构建集成

1. basin需要维护Dockerfile的镜像,需提交到gitlab中,每次对Dockerfile修改,自动触发持续构建程,构建流程:
    见:  [持续交付说明](/chi-xu-jiao-fu-shuo-ming.md)
2. 共有库(redis,mongod)不需要持续构建
3. 业务系统,需要@陈牵,@陈予言,增加构建脚本,完成持续构建.



