# 打包部署
包含打包和测试过程, 通过build.sh脚本进行打包,test.sh进行测试,其他项目类似,只有通过这两个脚本打包测试通过,才能够申请加入到持续集成中(持续集成也是调这两个脚本)

## 1.测试环境变量
    参见[整体研发环境信息](xi-tong-huan-jing.md)
## 2. 打包

```
sh build.sh
```

执行后会自动生成basin-spider和pyspider docker image,并自动上传到私有仓库.


## 3. 测试

```
sh test.sh
```

当前test.sh 测试内容包含
1. 端口连通测试
2. 冒烟测试