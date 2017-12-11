# 持续集成使用说明(未完)
项目持续运行,需要纳入持续集成框架.

## 运行中项目
+ bidspy
    + bidspy_build_all
    + bidspy_test
    
+ spider
    + spider_build_all
    + bidspy_test


## 持续集成使用说明
持续集成暂由bansin组成员添加
需向basin成员提交以下内容:
1. git地址
2. 需要的环境变量,例如
    export PRIVATE_REGISTRY=10.142.55.199:5006
2. 编译脚本(build.sh) 内容由开发人员自行编写,但本地执行build.sh在能build.sh编译完整部署包.
3. 失败接收的邮箱账号
4. 测试脚本(test.sh) 内容由开发人员自行编写,本地执行test.sh能正常测试通过.
5. 是否需每日构建,构建时间

