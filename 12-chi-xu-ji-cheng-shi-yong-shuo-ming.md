# 持续集成使用说明
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
需提交以下内容:
1. git地址
2. 需要的环境变量,例如
    export PRIVATE_REGISTRY=10.142.55.199:5006
2. 编译脚本(build.sh) 内容由开发人员自行编写,但build.sh在本地需能build.sh完整.
3. 失败接收的邮箱账号
4. 